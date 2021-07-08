//
//  UserAPIRouter.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//

import Alamofire

enum UserAPIRouter: AlamofireAPIRouteable {

    case signIn(idx: String, password: String)
    case user(idx: String)

    var _method: HTTPMethod {
        switch self {
        case .user:
            return .get
        case .signIn:
            return .post
        }
    }

    var path: String {
        switch self {
        // user
        case .user(let idx):
            return "/users/\(idx)"
        case .signIn:
            return "/users/signin"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .signIn(let idx, let password):
            return ["idx": idx, "upasswd": password]
        default:
            return nil
        }
    }
}
