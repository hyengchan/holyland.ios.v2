//
//  UserNetworkService.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//

import Foundation
import RxSwift
import Alamofire

final class UserNetworkService: NetworkService {

    class func signIn(idx: String, password: String) -> Single<Result<UserId, Error>> {
        let router = UserAPIRouter.signIn(idx: idx, password: password)
        return NetworkService.getJson(router)
            .catch({ (error) in .error(error) })
            .map { (result) in
                switch result {
                case .success(let jsonObject):
                    if let userIdx = jsonObject["idx"] as? Int {
                        return .success(userIdx)
                    } else {
                        return .failure(SerializationError.missing("idx"))
                    }
                case .failure(let error):
                    return .failure(error)
                }
            }
    }

    class func userInfo(idx: String) -> Single<Result<UserResponse, Error>> {
        let router = UserAPIRouter.user(idx: idx)
        return NetworkService.get(router)
    }
}
