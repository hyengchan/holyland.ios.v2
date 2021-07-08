//
//  MainViewModel.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/08.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
import Action
import Swinject
import NSObject_Rx

class MainViewModel: ViewModelType {
    
    private let container: Container
    private let bag = DisposeBag()

    private let myPageSubject = PublishSubject<Void>()
    private let qrPageSubject = PublishSubject<Void>()
    private let profileSubject = PublishSubject<Void>()

    // MARK: Input properties

    // MARK: Output properties
    private let userRepository: UserRepository
    private let goldKeyRepository: GoldKeyRepository

    struct Input {
        let myPageTap: PublishSubject<Void>
        let qrPageTap: PublishSubject<Void>
        let profileTap: PublishSubject<Void>
    }

    struct Output {
        let user: BehaviorRelay<User?>
        let goldkey: BehaviorRelay<Int>
        let holylevel: BehaviorRelay<Int>
        let obtainableGoldKeys: BehaviorRelay<GoldKeyResponse?>
    }

    let input: Input
    let output: Output
    
    init(userRepository: UserRepository, goldKeyRepository: GoldKeyRepository, container: Container) {
        self.userRepository = userRepository
        self.goldKeyRepository = goldKeyRepository
        self.container = container
        
        input = Input(myPageTap: myPageSubject,
                      qrPageTap: qrPageSubject,
                      profileTap: profileSubject)
        output = Output(user: self.userRepository.user,
                        goldkey: self.goldKeyRepository.goldkey,
                        holylevel: self.goldKeyRepository.holyLevel,
                        obtainableGoldKeys: self.goldKeyRepository.obtainableGoldKeys)
    }

    func didTapMyPage() -> CocoaAction {
        return CocoaAction { [unowned self] in
            myPageSubject.onNext(())
            return Observable.empty()
        }
    }

    func didTapQR() -> CocoaAction {
        return CocoaAction { [unowned self] in
            qrPageSubject.onNext(())
            return Observable.empty()
        }
    }
}
