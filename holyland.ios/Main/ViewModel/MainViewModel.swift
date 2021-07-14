//
//  MainViewModel.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/08.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
import Action
import Swinject
import NSObject_Rx

class MainViewModel: ViewModelType {
    
    private let container: Container
    private let bag = DisposeBag()

    private let myPageSubject = PublishSubject<Void>()
    private let qrPageSubject = PublishSubject<Void>()
    private let profileSubject = PublishSubject<Void>()
    private let didTapVideo = PublishSubject<VideoInformation.VideoKind>()

    private let willEnterForegroundSubject = PublishSubject<Void>()

    // MARK: Input properties

    // MARK: Output properties
    private let goldKeyRepository: GoldKeyRepository

    struct Input {
        let myPageTap: PublishSubject<Void>
        let qrPageTap: PublishSubject<Void>
        let profileTap: PublishSubject<Void>
        let didTapVideo: AnyObserver<VideoInformation.VideoKind>
    }

    struct Output { let willEnterForeground: Driver<Void> }

    let input: Input
    let output: Output
    
    init(goldKeyRepository: GoldKeyRepository, container: Container) {
        self.goldKeyRepository = goldKeyRepository
        self.container = container
        
        input = Input(myPageTap: myPageSubject,
                      qrPageTap: qrPageSubject,
                      profileTap: profileSubject,
                      didTapVideo: didTapVideo.asObserver())
        output = Output(willEnterForeground: willEnterForegroundSubject.asDriverOnErrorJustComplete())
    }

    func didTapMyPage() -> CocoaAction {
        return CocoaAction { [unowned self] in
            myPageSubject.onNext(())
            return Observable.empty()
        }
    }

    func didTapQR() -> CocoaAction {
        return CocoaAction { [unowned self] in
            qrPageSubject.onNext(())
            return Observable.empty()
        }
    }
}
