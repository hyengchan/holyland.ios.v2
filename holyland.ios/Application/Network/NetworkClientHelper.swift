//
//  NetworkClientHelper.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/10.
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
    case dataIsNil
    case missing(String)
    case invalid(String, Any)
}

open class NetworkClientHelper {
    
    typealias JSONObject = [String: Any]
    private static let successRange = 200..<300
    
    private static let storage = RemoteAccessTokenStorage(token: "f7c42d12-ecf6-4760-bc14-fdbd04dc1332")
    static let session = Session(interceptor: RequestInterceptor(storage: storage))
    
    class func request<T: Decodable>(_ urlConvertible: URLRequestConvertible) -> Single<NetworkResult<T>> {
        return Single.create { single in
              let request = session.request(urlConvertible)
                .responseDecodable(of: T.self) { response in
                  switch response.result {
                  case .success(let value):
                    single(.success(.success(value)))
                  case .failure(let error):
                    guard !error.isSessionTaskError else {
                        // no internet connection
                        single(.success(.error(NetworkError.endpointError)))
                        return
                    }
                    // other failures
                    if let statusCode = response.response?.statusCode,
                       let networkError = NetworkError(rawValue: statusCode) {
                        // Observable이 error 이벤트를 발생시키지 않게하여 해당 Stream이 종료되지 않게하고, error처리도 가능하게 해줌
                        single(.success(.error(networkError)))
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
    
    class func request(_ urlConvertible: URLRequestConvertible) -> Single<JSONObject> {
        return Single.create { single in
              let request = session.request(urlConvertible)
                .validate(statusCode: successRange)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        guard let jsonObject = value as? NetworkClient.JSONObject else {
                            single(.failure((SerializationError.missing("JSONObject"))))
                            return
                        }
                        if jsonObject.isEmpty {
                            single(.failure(SerializationError.dataIsNil))
                        } else {
                            single(.success(jsonObject))
                        }
                      
                    case .failure(let error):
                        if error.isSessionTaskError {
                            // no internet connection
                            single(.failure((NetworkError.endpointError)))
                        }
                        single(.failure(error))
                    }
                }
              return Disposables.create {
                request.cancel()
              }
        }
        .debug("request \(urlConvertible)")
    }
    
    class func requestData(_ urlConvertible: URLRequestConvertible) -> Single<Data?> {
        return Single.create { single in
              let request = session.request(urlConvertible)
                .validate(statusCode: successRange)
                .response { (response) in
                    single(.success(response.data))
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
    
    class func requestSuccess(_ urlConvertible: URLRequestConvertible,
                       successRangeCodes: [Int] = [200]) -> Single<Bool> {
        return Single.create { single in
              let request = session.request(urlConvertible)
                .response { (response) in
                    if let resultCode = response.response?.statusCode,
                       successRangeCodes.contains(resultCode) {
                        single(.success(true))
                    } else {
                        single(.success(false))
                    }
                }
              return Disposables.create {
                request.cancel()
              }
        }
        .debug("request \(urlConvertible)")
    }
    
    class func upload(_ urlConvertible: URLRequestConvertible,
                      multipartFormData: @escaping (MultipartFormData) -> Void) -> Single<JSONObject> {
        return Single.create { single in
            let request = session.upload(multipartFormData: multipartFormData, with: urlConvertible)
                .responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success(let value):
                        if let jsonObject = value as? NetworkClient.JSONObject {
                            single(.success(jsonObject))
                        } else {
                            single(.failure(SerializationError.dataIsNil))
                        }
                      
                    case .failure(let error):
                        single(.failure(error))
                    }
                })
              return Disposables.create {
                request.cancel()
              }
        }
        .debug("upload \(urlConvertible)")
    }
}
