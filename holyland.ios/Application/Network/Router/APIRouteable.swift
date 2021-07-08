//
//  APIRouteable.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//

import Foundation
import Alamofire

protocol APIRouteable {
    var serverURLPath: String { get }
    var method: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
}

extension APIRouteable {
    var serverURLPath: String {
        Constants.AppURL.baseURL
    }
}
