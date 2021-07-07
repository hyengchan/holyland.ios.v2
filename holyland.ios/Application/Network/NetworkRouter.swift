//
//  NetworkRouter.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/10.
//

import Foundation
import Alamofire

enum NetworkRouter {
    static let urlPath = Constants.AppURL.baseURL
    
    // about user
    case signIn(idx: String, password: String)
    case user(idx: String)
    case updateUserProfilePhoto
    case updateUserEmotion(idx: String, emotion: String)
    case updateUserPassword(idx: String, current: String, new: String)
    case attendances(idx: String)
    case childs(classIdx: String)
    case allChilds
    
    // about video
    case videoDay(classIdx: String)
    case videoNight
    case videoLive(classIdx: String)
    
    // about goldkey
    case checkObtainableGoldkeys(idx: String)
    /// request goldkey creation
    case requestWeekDayOnGoldkeyCreation(idx: String)
    case requestWeekDayOffGoldkeyCreation(idx: String)
    case requestWeekNightOnGoldkeyCreation(idx: String)
    case requestWeekNightOffGoldkeyCreation(idx: String)
    case requestLiveViewGoldkeyCreation(idx: String)
    case requestEarlyLoveGoldkeyCreation(idx: String)
    case requestFirePillarGoldkeyCreation(idx: String)
    case requestMorningTreatGoldkeyCreation(idx: String)
    case requestRouletteSmallGoldkeyCreation(idx: String)
    case requestRouletteLargeGoldkeyCreation(idx: String)
    case requestBoxCrashSmallGoldkeyCreation(idx: String)
    case requestBoxCrashLargeGoldkeyCreation(idx: String)
    
    // about appbar
    case dayAppbarImage
    case nightAppbarImage
    
    var method: HTTPMethod {
        switch self {
        case .user,
             .videoDay,
             .videoNight,
             .videoLive,
             .checkObtainableGoldkeys,
             .attendances,
             .childs,
             .allChilds,
             .dayAppbarImage,
             .nightAppbarImage:
            return .get
        case .signIn,
             .requestWeekDayOnGoldkeyCreation, .requestWeekDayOffGoldkeyCreation,
             .requestWeekNightOnGoldkeyCreation, .requestWeekNightOffGoldkeyCreation,
             .requestLiveViewGoldkeyCreation,
             .requestEarlyLoveGoldkeyCreation, .requestMorningTreatGoldkeyCreation, .requestFirePillarGoldkeyCreation,
             .requestRouletteSmallGoldkeyCreation, .requestRouletteLargeGoldkeyCreation,
             .requestBoxCrashSmallGoldkeyCreation, .requestBoxCrashLargeGoldkeyCreation:
            return .post
        case .updateUserProfilePhoto, .updateUserEmotion, .updateUserPassword:
            return .patch
        }
    }
    
    var path: String {
        switch self {
        // user
        case .user(let idx):
            return "/users/\(idx)"
        case .signIn:
            return "/users/signin"
        case .updateUserProfilePhoto:
            return "/users/photo"
        case .updateUserEmotion:
            return "/users/emotion"
        case .updateUserPassword:
            return "/users/passwd"
        case .attendances(let idx):
            return "/users/attend/\(idx)"
        case .childs(let classIdx):
            return "/users/dept/\(classIdx)"
        case .allChilds:
            return "/users"
            
        // video
        case .videoDay(let classIdx):
            return "/videos/day/\(classIdx)"
        case .videoNight:
            return "/videos/night"
        case .videoLive(let classIdx):
            return "/lives/\(classIdx)"

        // goldkey
        case .checkObtainableGoldkeys(idx: let idx):
            return "/goldkey/check/\(idx)"
        case .requestWeekDayOnGoldkeyCreation:
            return "/goldkey/week-day-on"
        case .requestWeekDayOffGoldkeyCreation:
            return "/goldkey/week-day-off"
        case .requestWeekNightOnGoldkeyCreation:
            return "/goldkey/week-night-on"
        case .requestWeekNightOffGoldkeyCreation:
            return "/goldkey/week-night-off"
        case .requestLiveViewGoldkeyCreation:
            return "/goldkey/live-view"
        case .requestEarlyLoveGoldkeyCreation:
            return "/goldkey/earlylove"
        case .requestFirePillarGoldkeyCreation:
            return "/goldkey/firepillar"
        case .requestMorningTreatGoldkeyCreation:
            return "/goldkey/morningtreat"
        case .requestRouletteSmallGoldkeyCreation:
            return "/goldkey/roulette-small"
        case .requestRouletteLargeGoldkeyCreation:
            return "/goldkey/roulette-large"
        case .requestBoxCrashSmallGoldkeyCreation:
            return "/goldkey/boxcrash-small"
        case .requestBoxCrashLargeGoldkeyCreation:
            return "/goldkey/boxcrash-large"
            
        // appbar
        case .dayAppbarImage:
            return "appbar/day"
        case .nightAppbarImage:
            return "appbar/night"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .signIn(let idx, let password):
            return ["idx": idx, "upasswd": password]
        case .updateUserEmotion(let idx, let emotion):
            return ["idx": idx, "emotion": emotion]
        case .updateUserPassword(let idx, let current, let new):
            return ["idx": idx, "old_passwd": current, "new_passwd": new]
        case .requestWeekDayOnGoldkeyCreation(let idx),     .requestWeekDayOffGoldkeyCreation(let idx),
             .requestWeekNightOnGoldkeyCreation(let idx),   .requestWeekNightOffGoldkeyCreation(let idx),
             .requestLiveViewGoldkeyCreation(let idx),      .requestEarlyLoveGoldkeyCreation(let idx),
             .requestMorningTreatGoldkeyCreation(let idx),  .requestFirePillarGoldkeyCreation(let idx),
             .requestRouletteLargeGoldkeyCreation(let idx), .requestRouletteSmallGoldkeyCreation(let idx),
             .requestBoxCrashSmallGoldkeyCreation(let idx), .requestBoxCrashLargeGoldkeyCreation(let idx):
            return ["user_idx": idx]
        default:
            return nil
        }
    }
}

extension NetworkRouter: URLConvertible {
    func asURL() throws -> URL {
        let url = try NetworkRouter.urlPath.asURL()
        return url.appendingPathComponent(path)
    }
}

extension NetworkRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        var request = try URLRequest(url: asURL())
        request.httpMethod = method.rawValue
        request.timeoutInterval = 30 // secs
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
