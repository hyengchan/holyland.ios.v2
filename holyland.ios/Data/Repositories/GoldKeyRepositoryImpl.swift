//
//  GoldKeyRepositoryImpl.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/08.
//

import Foundation
import RxSwift
import RxCocoa

final class GoldKeyRepositoryImpl: GoldKeyRepository {

    private let goldKeyDataSource: GoldKeyDataSource

    init(goldKeyDataSource: GoldKeyDataSource) {
        self.goldKeyDataSource = goldKeyDataSource
    }

    func checkObtainableGoldKey(idx: Int) -> Observable<GoldKeyResponse?> {
        goldKeyDataSource.checkObtainableGoldKeys(idx: idx)
    }

    func requestWeekDayOnGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        self.goldKeyDataSource.requestWeekDayOnGoldkeyCreation(idx: idx)
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }

    func requestWeekDayOnGoldkeyCreationOfWithOtherUser(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        self.goldKeyDataSource.requestWeekDayOnGoldkeyCreation(idx: idx)
    }

    func requestWeekDayOffGoldkeyCreation(idx: Int) -> Observable<String?> {
        self.goldKeyDataSource.requestWeekDayOffGoldkeyCreation(idx: idx)

    }

    func requestWeekNightOnGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        self.goldKeyDataSource.requestWeekNightOnGoldkeyCreation(idx: idx)
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }

    func requestWeekNightOnGoldkeyCreationOfWithOtherUser(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        self.goldKeyDataSource.requestWeekNightOnGoldkeyCreation(idx: idx)
    }

    func requestWeekNightOffGoldkeyCreation(idx: Int) -> Observable<String?> {
        self.goldKeyDataSource.requestWeekNightOffGoldkeyCreation(idx: idx)

    }

    func requestLiveViewGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        return self.goldKeyDataSource.requestLiveViewGoldkeyCreation(idx: idx)
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }

    func requestEarlyLoveGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        self.goldKeyDataSource.requestEarlyLoveGoldkeyCreation(idx: idx)
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }

    func requestFirePillarGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        self.goldKeyDataSource.requestFirePillarGoldkeyCreation(idx: idx)
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }

    func requestMorningTreatGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        self.goldKeyDataSource.requestMorningTreatGoldkeyCreation(idx: idx)
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }

    func requestRouletteSmallGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        self.goldKeyDataSource.requestRouletteSmallGoldkeyCreation(idx: idx)
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }

    func requestRouletteLargeGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        self.goldKeyDataSource.requestRouletteLargeGoldkeyCreation(idx: idx)
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }

    func requestBoxCrashSmallGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        self.goldKeyDataSource.requestBoxCrashSmallGoldkeyCreation(idx: idx)
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }

    func requestBoxCrashLargeGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        self.goldKeyDataSource.requestBoxCrashLargeGoldkeyCreation(idx: idx)
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }
}
