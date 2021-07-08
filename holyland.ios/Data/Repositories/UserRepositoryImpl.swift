//
//  UserRepositoryImpl2.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject

final class UserRepositoryImpl: UserRepository {
    private let userRemoteDataSource: UserRemoteDataSource
    private let userLocalDataSource: UserLocalDataSouce

    private(set) var user = BehaviorRelay<User?>(value: nil)

    init(userDataSource: UserRemoteDataSource,
         localDataSource: UserLocalDataSouce) {
        self.userRemoteDataSource = userDataSource
        self.userLocalDataSource = localDataSource
    }

    func siginIn(credentials: Credentials) -> Observable<Result<Int, Error>> {
        userRemoteDataSource.siginIn(idx: credentials.idx,
                                     password: credentials.password)
            .asObservable()
    }

    func userInfo(idx: Int) -> Observable<Result<User, Error>> {
        let result = userRemoteDataSource.userInfo(idx: String(idx)).asObservable()
        result
            .addSchedulers()
            .compactMap { $0 }
            .do(onNext: { response in
                switch response {
                case .success(let user):
                    self.user.accept(user)
                case .failure(let error):
                    print(error)
                }
            })
        return result
//            .addSchedulers()
//            .compactMap { $0 }
//            .do(onNext: { response in
//                switch response {
//                case .success(let user):
//                    self.user.onNext(user)
//                case .failure(let error):
//                    print(error)
//                }
//            })
    }

    @discardableResult
    func saveUser(_ user: User) -> Observable<Void> {
        userLocalDataSource.saveUser(UserEntityMapper.toStorableObject(entity: user))
            .andThen(Observable.just(Void()))
    }
}
