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
    var goldkey: BehaviorRelay<Int> { get }
    var holyLevel: BehaviorRelay<Int> { get }
    var obtainableGoldKeys: BehaviorRelay<GoldKeyResponse?> { get }

    func checkObtainableGoldKey(idx: Int) -> Observable<GoldKeyResponse?>
    func requestWeekDayOnGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?>
    func requestWeekDayOffGoldkeyCreation(idx: Int) -> Observable<String?>
    func requestWeekNightOnGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?>
    func requestWeekNightOffGoldkeyCreation(idx: Int) -> Observable<String?>
    func requestLiveViewGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?>
    func requestEarlyLoveGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?>
    func requestFirePillarGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?>
    func requestMorningTreatGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?>
    func requestRouletteSmallGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?>
    func requestRouletteLargeGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?>
    func requestBoxCrashSmallGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?>
    func requestBoxCrashLargeGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?>

    func requestWeekDayOnGoldkeyCreationOfWithOtherUser(idx: Int) -> Observable<GoldKeyInfoResponse?>
    func requestWeekNightOnGoldkeyCreationOfWithOtherUser(idx: Int) -> Observable<GoldKeyInfoResponse?>
}
