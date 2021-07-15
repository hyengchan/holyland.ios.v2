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

    func checkObtainableGoldKey(idx: Int) -> Observable<Result<GoldKeyResponse, Error>> {
        self.goldKeyDataSource.checkObtainableGoldKeys(idx: idx).asObservable()
    }

    func requestWeekDayOnGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>> {
        self.goldKeyDataSource.requestWeekDayOnGoldkeyCreation(idx: idx).asObservable()

    }

    func requestWeekDayOnGoldkeyCreationOfWithOtherUser(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>> {
        self.goldKeyDataSource.requestWeekDayOnGoldkeyCreation(idx: idx).asObservable()
    }

    func requestWeekDayOffGoldkeyCreation(idx: Int) -> Observable<Result<String, Error>> {
        self.goldKeyDataSource.requestWeekDayOffGoldkeyCreation(idx: idx).asObservable()

    }

    func requestWeekNightOnGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>> {
        self.goldKeyDataSource.requestWeekNightOnGoldkeyCreation(idx: idx).asObservable()
    }

    func requestWeekNightOnGoldkeyCreationOfWithOtherUser(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>> {
        self.goldKeyDataSource.requestWeekNightOnGoldkeyCreation(idx: idx).asObservable()
    }

    func requestWeekNightOffGoldkeyCreation(idx: Int) -> Observable<Result<String, Error>> {
        self.goldKeyDataSource.requestWeekNightOffGoldkeyCreation(idx: idx).asObservable()

    }

    func requestLiveViewGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>> {
        self.goldKeyDataSource.requestLiveViewGoldkeyCreation(idx: idx).asObservable()
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }

    func requestEarlyLoveGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>> {
        self.goldKeyDataSource.requestEarlyLoveGoldkeyCreation(idx: idx).asObservable()
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }

    func requestFirePillarGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>> {
        self.goldKeyDataSource.requestFirePillarGoldkeyCreation(idx: idx).asObservable()
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }

    func requestMorningTreatGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>> {
        self.goldKeyDataSource.requestMorningTreatGoldkeyCreation(idx: idx).asObservable()
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }

    func requestRouletteSmallGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>> {
        self.goldKeyDataSource.requestRouletteSmallGoldkeyCreation(idx: idx).asObservable()
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }

    func requestRouletteLargeGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>> {
        self.goldKeyDataSource.requestRouletteLargeGoldkeyCreation(idx: idx).asObservable()
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }

    func requestBoxCrashSmallGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>> {
        self.goldKeyDataSource.requestBoxCrashSmallGoldkeyCreation(idx: idx).asObservable()
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }

    func requestBoxCrashLargeGoldkeyCreation(idx: Int) -> Observable<Result<GoldKeyInfoResponse, Error>> {
        self.goldKeyDataSource.requestBoxCrashLargeGoldkeyCreation(idx: idx).asObservable()
//            .map { [weak self] in
//                if let info = $0 {
//                    self?.goldkey.accept(info.total)
//                    self?.holyLevel.accept(info.holyLevel)
//                }
//                return $0
//            }
    }
}
