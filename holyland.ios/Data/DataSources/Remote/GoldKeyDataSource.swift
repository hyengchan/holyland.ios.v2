//
//  GoldKeyDataSource.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/08.
//

import Foundation
import RxSwift

protocol GoldKeyDataSource {
    func checkObtainableGoldKeys(idx: Int) -> Observable<GoldKeyResponse?>
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
}

final class GoldKeyDataSourceImpl: GoldKeyDataSource {
    func checkObtainableGoldKeys(idx: Int) -> Observable<GoldKeyResponse?> {
        return GoldKeyNetworkService.checkObtainableGoldKeys(idx: idx)
            .asObservable()
            .flatMap { result -> Observable<GoldKeyResponse?> in
                switch result {
                case .success(let goldkeyInfo):
                    return Observable.just(goldkeyInfo)
                case .error(let error):
                    return Observable.error(error)
                }
            }
            .catch { (error) -> Observable<GoldKeyResponse?> in
                return Observable.error(error)
            }
    }

    func requestWeekDayOnGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        return GoldKeyNetworkService.requestWeekDayOnGoldkeyCreation(idx: idx)
            .asObservable()
            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
                switch result {
                case .success(let goldkeyInfo):
                    return Observable.just(goldkeyInfo)
                case .error:
                    return Observable.just(nil)
                }
            }
            .catch { _ -> Observable<GoldKeyInfoResponse?> in
                return Observable.just(nil)
            }
    }

    func requestWeekDayOffGoldkeyCreation(idx: Int) -> Observable<String?> {
        return GoldKeyNetworkService.requestWeekDayOffGoldkeyCreation(idx: idx)
            .asObservable()
    }

    func requestWeekNightOnGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        return GoldKeyNetworkService.requestWeekNightOnGoldkeyCreation(idx: idx)
            .asObservable()
            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
                switch result {
                case .success(let goldkeyInfo):
                    return Observable.just(goldkeyInfo)
                case .error:
                    return Observable.just(nil)
                }
            }
            .catch { _ -> Observable<GoldKeyInfoResponse?> in
                return Observable.just(nil)
            }
    }

    func requestWeekNightOffGoldkeyCreation(idx: Int) -> Observable<String?> {
        return GoldKeyNetworkService.requestWeekNightOffGoldkeyCreation(idx: idx)
            .asObservable()
    }

    func requestLiveViewGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        return GoldKeyNetworkService.requestLiveViewGoldkeyCreation(idx: idx)
            .asObservable()
            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
                switch result {
                case .success(let goldkeyInfo):
                    return Observable.just(goldkeyInfo)
                case .error:
                    return Observable.just(nil)
                }
            }
            .catch { _ -> Observable<GoldKeyInfoResponse?> in
                return Observable.just(nil)
            }
    }

    func requestEarlyLoveGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        return GoldKeyNetworkService.requestEarlyLoveGoldkeyCreation(idx: idx)
            .asObservable()
            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
                switch result {
                case .success(let goldkeyInfo):
                    return Observable.just(goldkeyInfo)
                case .error:
                    return Observable.just(nil)
                }
            }
            .catch { _ -> Observable<GoldKeyInfoResponse?> in
                return Observable.just(nil)
            }
    }

    func requestFirePillarGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        return GoldKeyNetworkService.requestFirePillarGoldkeyCreation(idx: idx)
            .asObservable()
            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
                switch result {
                case .success(let goldkeyInfo):
                    return Observable.just(goldkeyInfo)
                case .error:
                    return Observable.just(nil)
                }
            }
            .catch { _ -> Observable<GoldKeyInfoResponse?> in
                return Observable.just(nil)
            }
    }

    func requestMorningTreatGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        return GoldKeyNetworkService.requestMorningTreatGoldkeyCreation(idx: idx)
            .asObservable()
            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
                switch result {
                case .success(let goldkeyInfo):
                    return Observable.just(goldkeyInfo)
                case .error:
                    return Observable.just(nil)
                }
            }
            .catch { _ -> Observable<GoldKeyInfoResponse?> in
                return Observable.just(nil)
            }
    }

    func requestRouletteSmallGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        return GoldKeyNetworkService.requestRouletteSmallGoldkeyCreation(idx: idx)
            .asObservable()
            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
                switch result {
                case .success(let goldkeyInfo):
                    return Observable.just(goldkeyInfo)
                case .error:
                    return Observable.just(nil)
                }
            }
            .catch { _ -> Observable<GoldKeyInfoResponse?> in
                return Observable.just(nil)
            }
    }

    func requestRouletteLargeGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        return GoldKeyNetworkService.requestRouletteLargeGoldkeyCreation(idx: idx)
            .asObservable()
            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
                switch result {
                case .success(let goldkeyInfo):
                    return Observable.just(goldkeyInfo)
                case .error:
                    return Observable.just(nil)
                }
            }
            .catch { _ -> Observable<GoldKeyInfoResponse?> in
                return Observable.just(nil)
            }
    }

    func requestBoxCrashSmallGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        return GoldKeyNetworkService.requestBoxCrashSmallGoldkeyCreation(idx: idx)
            .asObservable()
            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
                switch result {
                case .success(let goldkeyInfo):
                    return Observable.just(goldkeyInfo)
                case .error:
                    return Observable.just(nil)
                }
            }
            .catch { _ -> Observable<GoldKeyInfoResponse?> in
                return Observable.just(nil)
            }
    }

    func requestBoxCrashLargeGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        return GoldKeyNetworkService.requestBoxCrashLargeGoldkeyCreation(idx: idx)
            .asObservable()
            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
                switch result {
                case .success(let goldkeyInfo):
                    return Observable.just(goldkeyInfo)
                case .error:
                    return Observable.just(nil)
                }
            }
            .catch { _ -> Observable<GoldKeyInfoResponse?> in
                return Observable.just(nil)
            }
    }
}
