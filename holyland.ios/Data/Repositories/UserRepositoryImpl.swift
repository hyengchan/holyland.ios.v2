//
//  UserRepositoryImpl2.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//

import Foundation
import RxSwift
import RxCocoa

final class UserRepositoryImpl: UserRepository {

    private let userRemoteDataSource: UserRemoteDataSource
    private let userLocalDataSource: UserLocalDataSouce

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
        userRemoteDataSource.userInfo(idx: String(idx)).asObservable()
    }

    @discardableResult
    func saveUser(_ user: User) -> Observable<Void> {
        userLocalDataSource.saveUser(UserEntityMapper.toStorableObject(entity: user))
            .andThen(Observable.just(Void()))
    }
}
