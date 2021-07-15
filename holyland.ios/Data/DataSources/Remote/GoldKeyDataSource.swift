//
//  GoldKeyDataSource.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/08.
//

import Foundation
import RxSwift

protocol GoldKeyDataSource {
    func checkObtainableGoldKeys(idx: Int) -> Single<Result<GoldKeyResponse, Error>>
    func requestWeekDayOnGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>>
    func requestWeekDayOffGoldkeyCreation(idx: Int) -> Single<Result<String, Error>>
    func requestWeekNightOnGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>>
    func requestWeekNightOffGoldkeyCreation(idx: Int) -> Single<Result<String, Error>>
    func requestLiveViewGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>>
    func requestEarlyLoveGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>>
    func requestFirePillarGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>>
    func requestMorningTreatGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>>
    func requestRouletteSmallGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>>
    func requestRouletteLargeGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>>
    func requestBoxCrashSmallGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>>
    func requestBoxCrashLargeGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>>
}

final class GoldKeyDataSourceImpl: GoldKeyDataSource {
    func checkObtainableGoldKeys(idx: Int) -> Single<Result<GoldKeyResponse, Error>> {
        GoldKeyNetworkService.checkObtainableGoldKeys(idx: idx)
//        return GoldKeyNetworkService.checkObtainableGoldKeys(idx: idx)
//            .asObservable()
//            .flatMap { result -> Result<GoldKeyResponse> in
//                switch result {
//                case .success(let goldkeyInfo):
//                    return Observable.just(goldkeyInfo)
//                case .error(let error):
//                    return Observable.error(error)
//                }
//            }
//            .catch { (error) -> Result<Error> in
//                return Observable.error(error)
//            }
    }

    func requestWeekDayOnGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        GoldKeyNetworkService.requestWeekDayOnGoldkeyCreation(idx: idx)
//            .asObservable()
//            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
//                switch result {
//                case .success(let goldkeyInfo):
//                    return Observable.just(goldkeyInfo)
//                case .error:
//                    return Observable.just(nil)
//                }
//            }
//            .catch { _ -> Observable<GoldKeyInfoResponse?> in
//                return Observable.just(nil)
//            }
    }

    func requestWeekDayOffGoldkeyCreation(idx: Int) -> Single<Result<String, Error>> {
        GoldKeyNetworkService.requestWeekDayOffGoldkeyCreation(idx: idx)
    }

    func requestWeekNightOnGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        return GoldKeyNetworkService.requestWeekNightOnGoldkeyCreation(idx: idx)
//            .asObservable()
//            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
//                switch result {
//                case .success(let goldkeyInfo):
//                    return Observable.just(goldkeyInfo)
//                case .error:
//                    return Observable.just(nil)
//                }
//            }
//            .catch { _ -> Observable<GoldKeyInfoResponse?> in
//                return Observable.just(nil)
//            }
    }

    func requestWeekNightOffGoldkeyCreation(idx: Int) -> Single<Result<String, Error>> {
        GoldKeyNetworkService.requestWeekNightOffGoldkeyCreation(idx: idx)
    }

    func requestLiveViewGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        return GoldKeyNetworkService.requestLiveViewGoldkeyCreation(idx: idx)
//            .asObservable()
//            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
//                switch result {
//                case .success(let goldkeyInfo):
//                    return Observable.just(goldkeyInfo)
//                case .error:
//                    return Observable.just(nil)
//                }
//            }
//            .catch { _ -> Observable<GoldKeyInfoResponse?> in
//                return Observable.just(nil)
//            }
    }

    func requestEarlyLoveGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        return GoldKeyNetworkService.requestEarlyLoveGoldkeyCreation(idx: idx)
//            .asObservable()
//            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
//                switch result {
//                case .success(let goldkeyInfo):
//                    return Observable.just(goldkeyInfo)
//                case .error:
//                    return Observable.just(nil)
//                }
//            }
//            .catch { _ -> Observable<GoldKeyInfoResponse?> in
//                return Observable.just(nil)
//            }
    }

    func requestFirePillarGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        return GoldKeyNetworkService.requestFirePillarGoldkeyCreation(idx: idx)
//            .asObservable()
//            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
//                switch result {
//                case .success(let goldkeyInfo):
//                    return Observable.just(goldkeyInfo)
//                case .error:
//                    return Observable.just(nil)
//                }
//            }
//            .catch { _ -> Observable<GoldKeyInfoResponse?> in
//                return Observable.just(nil)
//            }
    }

    func requestMorningTreatGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        return GoldKeyNetworkService.requestMorningTreatGoldkeyCreation(idx: idx)
//            .asObservable()
//            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
//                switch result {
//                case .success(let goldkeyInfo):
//                    return Observable.just(goldkeyInfo)
//                case .error:
//                    return Observable.just(nil)
//                }
//            }
//            .catch { _ -> Observable<GoldKeyInfoResponse?> in
//                return Observable.just(nil)
//            }
    }

    func requestRouletteSmallGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        return GoldKeyNetworkService.requestRouletteSmallGoldkeyCreation(idx: idx)
//            .asObservable()
//            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
//                switch result {
//                case .success(let goldkeyInfo):
//                    return Observable.just(goldkeyInfo)
//                case .error:
//                    return Observable.just(nil)
//                }
//            }
//            .catch { _ -> Observable<GoldKeyInfoResponse?> in
//                return Observable.just(nil)
//            }
    }

    func requestRouletteLargeGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        return GoldKeyNetworkService.requestRouletteLargeGoldkeyCreation(idx: idx)
//            .asObservable()
//            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
//                switch result {
//                case .success(let goldkeyInfo):
//                    return Observable.just(goldkeyInfo)
//                case .error:
//                    return Observable.just(nil)
//                }
//            }
//            .catch { _ -> Observable<GoldKeyInfoResponse?> in
//                return Observable.just(nil)
//            }
    }

    func requestBoxCrashSmallGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        return GoldKeyNetworkService.requestBoxCrashSmallGoldkeyCreation(idx: idx)
//            .asObservable()
//            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
//                switch result {
//                case .success(let goldkeyInfo):
//                    return Observable.just(goldkeyInfo)
//                case .error:
//                    return Observable.just(nil)
//                }
//            }
//            .catch { _ -> Observable<GoldKeyInfoResponse?> in
//                return Observable.just(nil)
//            }
    }

    func requestBoxCrashLargeGoldkeyCreation(idx: Int) -> Single<Result<GoldKeyInfoResponse, Error>> {
        return GoldKeyNetworkService.requestBoxCrashLargeGoldkeyCreation(idx: idx)
//            .asObservable()
//            .flatMap { result -> Observable<GoldKeyInfoResponse?> in
//                switch result {
//                case .success(let goldkeyInfo):
//                    return Observable.just(goldkeyInfo)
//                case .error:
//                    return Observable.just(nil)
//                }
//            }
//            .catch { _ -> Observable<GoldKeyInfoResponse?> in
//                return Observable.just(nil)
//            }
    }
}
