//
//  LoginViewModel.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/15.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
import Action
import Swinject
import NSObject_Rx

class LoginViewModel: ViewModelType {
    
    // MARK: properties
    private let bag = DisposeBag()
    private let userRepository: UserRepository
    private let container: Container

    // MARK: input properties
    private let idRelay = BehaviorRelay<String>(value: "")
    private let passwordRelay = BehaviorRelay<String>(value: "")
    private let didTapLoginButton = PublishSubject<Credentials>()

    // MARK: output properties
    private let credentialsObservable: Observable<Credentials>
    private let signInResultSubject = PublishSubject<User>()
    private let invalidLoginErrorsSubject = PublishSubject<Error>()
    private let serverConnectionErrorsSubject = PublishSubject<Error>()

    struct Credentials {
        let idx: String
        let password: String
    }

    private let topics: [String: String] = [
        "영유아부": Constants.Topic.infants,
        "유치부": Constants.Topic.kinder,
        "유년부": Constants.Topic.child,
        "초등부": Constants.Topic.elementary,
        "소년부": Constants.Topic.boys
    ]

    struct Input {
        let id: BehaviorRelay<String>
        let password: BehaviorRelay<String>
        let tapButton: PublishSubject<Credentials>
    }

    struct Output {
        let enableSignInButton: Driver<Bool>
        let credential: Observable<Credentials>
        let resultSubject: PublishSubject<User>
        let serverErrorObservable: Driver<Error>
        let loginErrorsObservable: Driver<Error>
    }

    let input: Input
    let output: Output
    
    init(userRepository: UserRepository, container: Container) {
        self.userRepository = userRepository
        self.container = container

        self.credentialsObservable = Observable.combineLatest(idRelay, passwordRelay) { (idx, password) in
            return Credentials(idx: idx, password: password)
        }

        let isConfirmEnabled = self.credentialsObservable
            .map { !$0.idx.isEmpty && !$0.password.isEmpty }
            .asDriver(onErrorJustReturn: false)

        input = Input(id: idRelay,
                      password: passwordRelay,
                      tapButton: didTapLoginButton)

        output = Output(enableSignInButton: isConfirmEnabled,
                        credential: credentialsObservable,
                        resultSubject: signInResultSubject,
                        serverErrorObservable: serverConnectionErrorsSubject.asDriverOnErrorJustComplete(),
                        loginErrorsObservable: invalidLoginErrorsSubject.asDriverOnErrorJustComplete())

        subscribeLoginButtonTap()
    }
}

extension LoginViewModel {

    func subscribeLoginButtonTap() {
        didTapLoginButton
            .flatMapLatest { [weak self] credentials -> Observable<Int?> in
                return (self?.signIn(with: credentials) ?? Observable.just(nil))
            }
            .addSchedulers()
            .compactMap { $0 }
            .flatMapLatest { (idx) in
                self.userInfo(by: idx)
            }
            .catch { [weak self] (error) -> Observable<User?> in
                self?.serverConnectionErrorsSubject.onNext(error)
                return Observable.never()
            }
            .asDriver(onErrorJustReturn: nil)
            .compactMap { $0 }
            .drive(onNext: { [weak self] (user) in
                self?.signInResultSubject.onNext(user)
            })
            .disposed(by: bag)
    }
    
    func signIn(with credentials: Credentials) -> Observable<Int?> {
        self.userRepository.siginIn(idx: credentials.idx, password: credentials.password)
            .catch { (error) -> Observable<Int?> in
                if let networkError = error as? NetworkError,
                   networkError == NetworkError.endpointError {
                    self.serverConnectionErrorsSubject.onNext(error)
                } else {
                    self.invalidLoginErrorsSubject.onNext(error)
                }
                return Observable.never()
            }

    }

    func userInfo(by idx: Int) -> Observable<User?> {
        self.userRepository.userInfo(idx: idx)
            .do(onNext: { [weak self] (user) in
                guard let user = user else { return }
                UserDefaultsStorage.saveLoggedInUserIdx(user.idx)
                UserDefaultsStorage.updateShouldDeletedWhenSignOut(with: false)
            })
    }
}
