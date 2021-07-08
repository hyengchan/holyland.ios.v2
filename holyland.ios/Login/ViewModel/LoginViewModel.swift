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

struct Credentials {
    let idx: String
    let password: String
}

class LoginViewModel {
    
    // MARK: properties
    private let bag = DisposeBag()
    private let userRepository: UserRepository
    private let container: Container

    // MARK: input properties
    private let idRelay = BehaviorRelay<String>(value: "")
    private let passwordRelay = BehaviorRelay<String>(value: "")
    private let didTapLoginButton = PublishSubject<Credentials>()

    // MARK: output properties
    private let signInResultSubject = PublishSubject<Void>()
    private let invalidLoginErrorsSubject = PublishSubject<Error>()
    private let serverConnectionErrorsSubject = PublishSubject<Error>()

    private let topics: [String: String] = [
        "영유아부": Constants.Topic.infants,
        "유치부": Constants.Topic.kinder,
        "유년부": Constants.Topic.child,
        "초등부": Constants.Topic.elementary,
        "소년부": Constants.Topic.boys
    ]

    let input: Input
    let output: Output

    lazy var signInObservable = didTapLoginButton
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
        .flatMapLatest { [unowned self] in self.userRepository.siginIn(credentials: $0) }
    
    init(userRepository: UserRepository, container: Container) {
        self.userRepository = userRepository
        self.container = container

        let credentialsObservable = Observable.combineLatest(idRelay, passwordRelay) { (idx, password) in
            return Credentials(idx: idx, password: password)
        }

        let isConfirmEnabled = credentialsObservable
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

        signInObservable
            .subscribe(onNext: { [unowned self] response in
                switch response {
                case .success(let idx):
                    userRepository.userInfo(idx: idx)
                    UserPersistentStorage.loggedInIdx = idx

                    self.signInResultSubject.onNext(())
                case .failure(let error):
                    if error is NetworkError, error as? NetworkError == NetworkError.endpointError {
                        self.serverConnectionErrorsSubject.onNext(error)
                    } else {
                        self.invalidLoginErrorsSubject.onNext(error)
                    }
                }
            })
            .disposed(by: bag)
    }
}

extension LoginViewModel: ViewModelType {
    struct Input {
        let id: BehaviorRelay<String>
        let password: BehaviorRelay<String>
        let tapButton: PublishSubject<Credentials>
    }

    struct Output {
        let enableSignInButton: Driver<Bool>
        let credential: Observable<Credentials>
        let resultSubject: PublishSubject<Void>
        let serverErrorObservable: Driver<Error>
        let loginErrorsObservable: Driver<Error>
    }
}
