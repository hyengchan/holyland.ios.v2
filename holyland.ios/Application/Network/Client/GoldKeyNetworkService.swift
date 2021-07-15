//
//  GoldKeyNetworkService.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/08.
//

import Foundation
import RxSwift
import Alamofire

final class GoldKeyNetworkService: NetworkService {

    class func checkObtainableGoldKeys(idx: Int) -> Single<Result<GoldKeyResponse, Error>> {
        let router = GoldKeyRouter.checkObtainableGoldkeys(idx: "\(idx)")
        return NetworkService.get(router)
    }

    class func requestWeekDayOnGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        let router = GoldKeyRouter.requestWeekDayOnGoldkeyCreation(idx: "\(idx)")
        return NetworkService.get(router)
    }

    class func requestWeekDayOffGoldkeyCreation(idx: Int) -> Single<Result<String, Error>> {
        let router = GoldKeyRouter.requestWeekDayOffGoldkeyCreation(idx: "\(idx)")
        return NetworkService.get(router)
//            .map { (jsonObject) -> String? in
//                jsonObject["uname"] as? String
//            }
    }

    class func requestWeekNightOnGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        let router = GoldKeyRouter.requestWeekNightOnGoldkeyCreation(idx: "\(idx)")
        return NetworkService.get(router)
    }

    class func requestWeekNightOffGoldkeyCreation(idx: Int) -> Single<Result<String, Error>> {
        let router = GoldKeyRouter.requestWeekNightOffGoldkeyCreation(idx: "\(idx)")
        return NetworkService.get(router)
//            .map { (jsonObject) -> String? in
//                jsonObject["uname"] as? String
//            }
    }

    class func requestLiveViewGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        let router = GoldKeyRouter.requestLiveViewGoldkeyCreation(idx: "\(idx)")
        return NetworkService.get(router)
    }

    class func requestEarlyLoveGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        let router = GoldKeyRouter.requestEarlyLoveGoldkeyCreation(idx: "\(idx)")
        return NetworkService.get(router)
    }

    class func requestFirePillarGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        let router = GoldKeyRouter.requestFirePillarGoldkeyCreation(idx: "\(idx)")
        return NetworkService.get(router)
    }

    class func requestMorningTreatGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        let router = GoldKeyRouter.requestMorningTreatGoldkeyCreation(idx: "\(idx)")
        return NetworkService.get(router)
    }

    class func requestRouletteSmallGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        let router = GoldKeyRouter.requestRouletteSmallGoldkeyCreation(idx: "\(idx)")
        return NetworkService.get(router)
    }

    class func requestRouletteLargeGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        let router = GoldKeyRouter.requestRouletteLargeGoldkeyCreation(idx: "\(idx)")
        return NetworkService.get(router)
    }

    class func requestBoxCrashSmallGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        let router = GoldKeyRouter.requestBoxCrashSmallGoldkeyCreation(idx: "\(idx)")
        return NetworkService.get(router)
    }

    class func requestBoxCrashLargeGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        let router = GoldKeyRouter.requestBoxCrashLargeGoldkeyCreation(idx: "\(idx)")
        return NetworkService.get(router)
    }

}
