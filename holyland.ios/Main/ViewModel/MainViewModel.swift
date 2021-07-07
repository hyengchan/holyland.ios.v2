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

    struct Input { }

    struct Output {
        let user: BehaviorRelay<User?>
        let myPageTap: PublishSubject<Void>
        let qrPageTap: PublishSubject<Void>
        let profileTap: PublishSubject<Void>
    }

    let input: Input
    let output: Output
    
    init(userRepository: UserRepository, container: Container) {
        self.userRepository = userRepository
        self.container = container
        
        input = Input()
        output = Output(user: self.userRepository.user,
                        myPageTap: myPageSubject,
                        qrPageTap: qrPageSubject,
                        profileTap: profileSubject)
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
