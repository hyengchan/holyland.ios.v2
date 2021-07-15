//
//  NetworkService.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//

import Foundation
import Alamofire
import RxSwift

enum NetworkResult<T: Decodable> {
    case success(T)
    case error(NetworkError)
}

enum NetworkError: Int, Error {
    case badRequest = 400
    case authenticationFailed = 401
    case forbidden = 403
    case notFound = 404
    case conflict = 409
    case systemError = 500
    case endpointError = 503
    case timeout = 504
}

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
    case decodingFailed
    case dataIsNil
}

open class NetworkService {

    typealias JSONObject = [String: Any]
    private static let successRange = 200..<300

    private static let storage = RemoteAccessTokenStorage(token: "f7c42d12-ecf6-4760-bc14-fdbd04dc1332")
    static let session = Session(interceptor: RequestInterceptor(storage: storage))

    class func get<T: Decodable>(_ urlConvertible: URLRequestConvertible) -> Single<Result<T, Error>> {
        return getResponseAny(urlConvertible)
            .flatMap { (result) -> Single<Result<T, Error>> in
                switch result {
                case .success(let value):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        let value = try JSONDecoder().decode(T.self, from: jsonData)
                        return Single.just(.success(value))
                    } catch let error {
                        print("JSONSerialization Error : ", error.localizedDescription)
                        return Single.just(.failure(SerializationError.decodingFailed))
                    }
                case .failure(let error):
                    return Single.just(.failure(error))
                }
            }
    }

    class func getJson(_ urlConvertible: URLRequestConvertible) -> Single<Result<JSONObject, Error>> {
        return getResponseAny(urlConvertible)
            .flatMap { (result) -> Single<Result<JSONObject, Error>> in
                switch result {
                case .success(let value):
                    if let jsonObject = value as? JSONObject, !jsonObject.isEmpty {
                        return Single.just(.success(jsonObject))
                    } else {
                        return Single.just(.failure(SerializationError.decodingFailed))
                    }
                case .failure(let error):
                    return Single.just(.failure(error))
                }
            }
    }
}

extension NetworkService {
    class func getResponseAny(_ urlConvertible: URLRequestConvertible) -> Single<Result<Any, Error>> {
        return Single.create { single in
              let request = session.request(urlConvertible)
                .validate(statusCode: successRange)
                .responseJSON { (response) in
                    switch response.result {
                    case .success(let value):
                        single(.success(.success(value)))
                    case .failure(let error):
                        guard !error.isSessionTaskError else {
                            single(.success(.failure(NetworkError.endpointError)))
                            return
                        }
                        if let networkError = response.response?.networkError {
                            single(.success(.failure(networkError)))
                        } else {
                            single(.failure(error))
                        }
                    }
                }
              return Disposables.create {
                request.cancel()
              }
        }
        .debug("request \(urlConvertible)")
    }

    class func requestString(_ urlConvertible: URLRequestConvertible) -> Single<String?> {
        return Single.create { single in
              let request = session.request(urlConvertible)
                .validate(statusCode: successRange)
                .responseString { (response) in
                    single(.success(response.value))
                }
            return Disposables.create {
                request.cancel()
            }
        }
        .debug("request \(urlConvertible)")
    }
}

fileprivate extension HTTPURLResponse {
    var networkError: NetworkError? {
        NetworkError(rawValue: self.statusCode)
    }
}
