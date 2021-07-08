//
//  AccessTokenStorage.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//

import Foundation
import Alamofire

protocol AccessTokenStorage: class {
    typealias Token = String
    var accessToken: Token { get }
}

final class RemoteAccessTokenStorage: AccessTokenStorage {
    let accessToken: Token

    init(token: Token) {
        accessToken = token
    }
}

final class RequestInterceptor: Alamofire.RequestInterceptor {

    private let storage: AccessTokenStorage

    init(storage: AccessTokenStorage) {
        self.storage = storage
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        // TODO :- APIRouteable.serverURLPath 사용할 수 있게
        guard urlRequest.url?.absoluteString.hasPrefix(Constants.AppURL.baseURL) == true else {
            // If the request does not require authentication, we can directly return it as unmodified.
            return completion(.success(urlRequest))
        }
        var urlRequest = urlRequest

        // Set the Authorization header value using the access token.
        urlRequest.setValue("Bearer " + storage.accessToken, forHTTPHeaderField: "Authorization")

        completion(.success(urlRequest))
    }
}
