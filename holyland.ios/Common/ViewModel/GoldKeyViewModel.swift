//
//  GoldKeyViewModel.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/09.
//

import RxSwift
import RxCocoa

class GoldKeyViewModel: ViewModelType {
    struct Input { }

    struct Output { }

    let input: Input
    let output: Output

    var disposeBag = DisposeBag()

    // MARK: - Private properties
    private let goldkeyRepository: GoldKeyRepository

    private(set) var goldkey = BehaviorSubject<Int>(value: 0)
    private(set) var holyLevel = BehaviorSubject<Int>(value: 0)
    private(set) var obtainableGoldKeys = BehaviorSubject<GoldKeyResponse?>(value: nil)

    let amountGoldkeysPerLevel = Constants.GoldKey.amountPerLevel

    init(goldkeyRepository: GoldKeyRepository) {
        self.goldkeyRepository = goldkeyRepository

        input = Input()
        output = Output()
    }

    func checkObtainableGoldkeys(idx: Int) {
        goldkeyRepository.checkObtainableGoldKey(idx: idx)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .compactMap { $0 }
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            //.do { print("HI")}
            .subscribe(onNext: { owner, user in
                owner.goldkey.onNext(user.total)
                owner.holyLevel.onNext(user.holyLevel)
                owner.obtainableGoldKeys.onNext(user)
            })
            .disposed(by: disposeBag)
        }

    func requestWeekDayOnGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        goldkeyRepository.requestWeekDayOnGoldkeyCreation(idx: idx)
    }

    func requestWeekDayOffGoldkeyCreation(idx: Int) -> Observable<String?> {
        goldkeyRepository.requestWeekDayOffGoldkeyCreation(idx: idx)
            .catchAndReturn(nil)
    }

    func requestWeekNightOnGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        goldkeyRepository.requestWeekNightOnGoldkeyCreation(idx: idx)
    }

    func requestWeekNightOffGoldkeyCreation(idx: Int) -> Observable<String?> {
        goldkeyRepository.requestWeekNightOffGoldkeyCreation(idx: idx)
            .catchAndReturn(nil)
    }

    func requestLiveViewGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        goldkeyRepository.requestLiveViewGoldkeyCreation(idx: idx)
    }

    func requestEarlyLoveGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        goldkeyRepository.requestEarlyLoveGoldkeyCreation(idx: idx)
    }

    func requestFirePillarGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        goldkeyRepository.requestFirePillarGoldkeyCreation(idx: idx)
    }

    func requestMorningTreatGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        goldkeyRepository.requestMorningTreatGoldkeyCreation(idx: idx)
    }

    func requestRouletteSmallGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        goldkeyRepository.requestRouletteSmallGoldkeyCreation(idx: idx)
    }

    func requestRouletteLargeGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        goldkeyRepository.requestRouletteLargeGoldkeyCreation(idx: idx)
    }

    func requestBoxCrashSmallGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        goldkeyRepository.requestBoxCrashSmallGoldkeyCreation(idx: idx)
    }

    func requestBoxCrashLargeGoldkeyCreation(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        goldkeyRepository.requestBoxCrashLargeGoldkeyCreation(idx: idx)
    }

    func requestWeekDayOnGoldkeyCreationOfWithOtherUser(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        goldkeyRepository.requestWeekDayOnGoldkeyCreationOfWithOtherUser(idx: idx)
    }

    func requestWeekNightOnGoldkeyCreationOfWithOtherUser(idx: Int) -> Observable<GoldKeyInfoResponse?> {
        goldkeyRepository.requestWeekNightOnGoldkeyCreationOfWithOtherUser(idx: idx)
    }
}
