//
//  UserViewModel.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/15.
//

import Foundation
import RxSwift

class UserViewModel: ViewModelType {
    let input: Input
    let output: Output
    var bag = DisposeBag()

    private let userRepository: UserRepository
    private(set) lazy var loginUser = BehaviorSubject<User?>(value: nil)

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        input = Input()
        output = Output()
    }

    func getSignedInUser(idx: Int) {
        userRepository.userInfo(idx: idx)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .compactMap { try $0.get() }
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .do(onNext: { owner, user in
                print("getSignedInUser", user)
                owner.userRepository.saveUser(user)
            })
            .subscribe(onNext: { owner, user in
                owner.loginUser.onNext(user)
            })
            .disposed(by: bag)
    }
}

extension UserViewModel {
    struct Input { }
    struct Output { }
}
