//
//  GoldKeyRouter.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/08.
//

import Alamofire

enum GoldKeyRouter: AlamofireAPIRouteable {
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

    var _method: HTTPMethod {
        switch self {
        case .checkObtainableGoldkeys:
            return .get
        case .requestWeekDayOnGoldkeyCreation, .requestWeekDayOffGoldkeyCreation,
             .requestWeekNightOnGoldkeyCreation, .requestWeekNightOffGoldkeyCreation,
             .requestLiveViewGoldkeyCreation, .requestEarlyLoveGoldkeyCreation,
             .requestFirePillarGoldkeyCreation, .requestMorningTreatGoldkeyCreation,
             .requestRouletteSmallGoldkeyCreation, .requestRouletteLargeGoldkeyCreation,
             .requestBoxCrashSmallGoldkeyCreation, .requestBoxCrashLargeGoldkeyCreation:
            return .post
        }
    }

    var path: String {
        switch self {
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
        }
    }

    var parameters: Parameters? {
        switch self {
        case .checkObtainableGoldkeys(let idx):
            return ["idx": idx]
        default:
            return nil
        }
    }
}
