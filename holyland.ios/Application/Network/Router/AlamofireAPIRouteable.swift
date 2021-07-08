//
//  AlamofireAPIRouteable.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//

import Alamofire

protocol AlamofireAPIRouteable: APIRouteable, URLConvertible, URLRequestConvertible {
    var _method: HTTPMethod { get }
}

extension AlamofireAPIRouteable {
    var method: String { _method.rawValue }
}

extension AlamofireAPIRouteable where Self: URLConvertible & URLRequestConvertible {
    func asURL() throws -> URL {
        let url = try self.serverURLPath.asURL()
        return url.appendingPathComponent(path)
    }

    func asURLRequest() throws -> URLRequest {
        var request = try URLRequest(url: asURL())
        request.httpMethod = method
        request.timeoutInterval = 30 // secs
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
