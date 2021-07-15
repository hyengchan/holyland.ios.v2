//
//  GoldKeyRepository.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/08.
//

import Foundation
import RxSwift
import RxCocoa

protocol GoldKeyRepository {
//    var goldkey: BehaviorRelay<Int> { get }
//    var holyLevel: BehaviorRelay<Int> { get }
//    var obtainableGoldKeys: BehaviorRelay<GoldKeyResponse?> { get }

    func checkObtainableGoldKey(idx: Int) ->  Observable<Result<GoldKeyResponse, Error>>
    func requestWeekDayOnGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>>
    func requestWeekDayOffGoldkeyCreation(idx: Int) -> Observable<Result<String, Error>>
    func requestWeekNightOnGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>>
    func requestWeekNightOffGoldkeyCreation(idx: Int) -> Observable<Result<String, Error>>
    func requestLiveViewGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>>
    func requestEarlyLoveGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>>
    func requestFirePillarGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>>
    func requestMorningTreatGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>>
    func requestRouletteSmallGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>>
    func requestRouletteLargeGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>>
    func requestBoxCrashSmallGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>>
    func requestBoxCrashLargeGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>>

    func requestWeekDayOnGoldkeyCreationOfWithOtherUser(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>>
    func requestWeekNightOnGoldkeyCreationOfWithOtherUser(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>>
}
