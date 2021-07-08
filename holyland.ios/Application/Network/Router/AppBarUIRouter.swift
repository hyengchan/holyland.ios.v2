//
//  AppBarUIRouter.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//

import Alamofire

enum AppBarUIRouter: AlamofireAPIRouteable {
    case dayAppbarImage
    case nightAppbarImage

    var _method: HTTPMethod {
        switch self {
        case .dayAppbarImage, .nightAppbarImage:
            return .get
        }
    }

    var path: String {
        switch self {
        case .dayAppbarImage:
            return "appbar/day"
        case .nightAppbarImage:
            return "appbar/night"
        }
    }

    var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }
}
