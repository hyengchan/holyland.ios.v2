//
//  UserDataSource2.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//

import Foundation
import RxSwift

typealias UserId = Int

protocol UserRemoteDataSource {
    func siginIn(idx: String, password: String) -> Single<Result<UserId, Error>>
    func userInfo(idx: String) -> Single<Result<User, Error>>
}

final class UserRemoteDataSourceImpl: UserRemoteDataSource {
    func siginIn(idx: String, password: String) -> Single<Result<UserId, Error>> {
        UserNetworkService.signIn(idx: idx, password: password)
    }

    func userInfo(idx: String) -> Single<Result<User, Error>> {
        UserNetworkService.userInfo(idx: idx)
            .map { result in
                switch result {
                case .success(let dto):
                    return .success(UserEntityMapper.fromNetworkResponseModel(dto: dto))
                case .failure(let error):
                    return .failure(error)
                }
            }
    }
}
