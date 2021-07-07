//
//  VideoListViewModel.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/06.
//

import RxSwift
import RxCocoa

class VideoListViewModel: ViewModelType {
    struct Input {
        let didTapVideo: AnyObserver<VideoInformation>
        let videoInfomations: AnyObserver<[VideoInformation]>
    }

    struct Output {
        let videoInfomations: Driver<[VideoInformation]>
        let selectionVideo: Driver<VideoInformation.VideoKind>
    }

    let input: Input
    let output: Output

    var disposeBag = DisposeBag()

    private let didTapVideoSubject = PublishSubject<VideoInformation>()
    private let videoInfomationsSubject = BehaviorSubject<[VideoInformation]>(value: [])
    private let selectionVideoSubject = PublishSubject<VideoInformation.VideoKind>()

    init() {
        input = Input(didTapVideo: didTapVideoSubject.asObserver(),
                      videoInfomations: videoInfomationsSubject.asObserver())
        output = Output(videoInfomations: videoInfomationsSubject.asDriver(onErrorJustReturn: []),
                        selectionVideo: selectionVideoSubject.asDriverOnErrorJustComplete())

        didTapVideoSubject
            .map { (videoInformation) -> VideoInformation.VideoKind in
                videoInformation.kind
            }
            .bind(to: selectionVideoSubject)
            .disposed(by: disposeBag)
    }
}
