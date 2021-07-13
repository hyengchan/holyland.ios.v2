//
//  ViewController.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/01.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import Foundation
import SnapKit
import Kingfisher
import NSObject_Rx

class MainViewController: BaseViewController {
    
    // Properties
    private var lastGoldkey = 0
    private var lastHolyLevel = 0
    
    var viewModel: MainViewModel!
    var userViewModel: UserViewModel!
    var goldkeyViewModel: GoldKeyViewModel!
    var videoListViewModel: VideoListViewModel!

    lazy var mainView = MainView(frame: self.view.frame)
    
    lazy var viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:))).mapToVoid().asObservable()
    lazy var viewDidAppear = rx.sentMessage(#selector(UIViewController.viewDidAppear(_:))).mapToVoid().asObservable()
    lazy var userObservable = userViewModel.loginUser.compactMap { $0 }
    lazy var goldKeyObservable = goldkeyViewModel.obtainableGoldKeys.compactMap { $0 }

    override func viewDidLoad() {
        super.viewDidLoad()
        // swipe gesture 뒤로가기 금지
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        mainView.goldKeyProgressBar.makeRounded(radius: mainView.goldKeyProgressBar.bounds.height / 2)

        setupViews()
        bindUserViewModel()
        bindMainViewModel()
    }
    
    func bindUserViewModel() {

        let willEnterForeground = viewModel.output.willEnterForeground.asObservable()

        Observable.just(UserPersistentStorage.loggedInIdx)
            .compactMap { $0 }
            .withUnretained(self)
            .subscribe(onNext: { owner, idx in
                owner.userViewModel.getSignedInUser(idx: idx)
                owner.goldkeyViewModel.checkObtainableGoldkeys(idx: idx)
            })
            .disposed(by: rx.disposeBag)

        userObservable
            .asDriverOnErrorJustComplete()
            .drive(with: self, onNext: { owner, user in
                owner.mainView.profileView.configure(userPhotoURLPath: user.profileImage,
                                                     gender: user.gender,
                                                     emotion: user.emotion.rawValue,
                                                     userName: user.name,
                                                     className: user.className + "선생님반")
            })
            .disposed(by: disposeBag)

        goldKeyObservable
            .take(1)
            .asDriverOnErrorJustComplete()
            .drive(with: self, onNext: { (owner, event)  in
                owner.lastGoldkey = event.total
                owner.lastHolyLevel = event.holyLevel
            })
            .disposed(by: rx.disposeBag)

        goldKeyObservable
            .map { (obtainableGoldKeyInfo) -> [VideoInformation] in
                return [VideoInformation(kind: .vimeo(type: .day), viewable: obtainableGoldKeyInfo.weekDay),
                        VideoInformation(kind: .vimeo(type: .night), viewable: obtainableGoldKeyInfo.weekNight),
                        VideoInformation(kind: .vimeo(type: .live)),
                        VideoInformation(kind: .youtube(type: .earlyLoveBible)),
                        VideoInformation(kind: .youtube(type: .firePillarBible)),
                        VideoInformation(kind: .youtube(type: .morningTreatBible))]
            }
            .do { print("ISHDGHSDIOGHSDGOI", $0) }
            .bind(to: videoListViewModel.input.videoInfomations)
            .disposed(by: disposeBag)

        videoListViewModel.output.videoInfomations
            .drive(mainView.videoCollectionView.collectionView.rx.items(cellIdentifier: VideoCollectionViewCell.identifier,
                                                                        cellType: VideoCollectionViewCell.self)) { (_, element, cell) in
                cell.configure(with: element)
            }
            .disposed(by: disposeBag)

        mainView.videoCollectionView.collectionView.rx
            .modelSelected(VideoInformation.self)
            .bind(to: videoListViewModel.input.didTapVideo)
            .disposed(by: disposeBag)

        let goldkeyInfoObservable = userObservable
            .flatMap { [unowned self] _ in
                Observable.zip(goldkeyViewModel.goldkey, goldkeyViewModel.holyLevel)
            }
            .skip(1)
            .share()

        goldkeyInfoObservable
            .take(1)
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] (item) in
                self?.lastGoldkey = item.0
                self?.lastHolyLevel = item.1
            })
            .disposed(by: disposeBag)

        let goldkeyMessageObservable = goldkeyInfoObservable
            .distinctUntilChanged({ return $0 == $1 })
            .map { [unowned self] info -> (Int, Int) in
                let goldkey = info.0
                let level = info.1
                let goldkeyAmountPerLevel = Constants.GoldKey.amountPerLevel
                let goldkeyCount = trunc(Float(goldkey % goldkeyAmountPerLevel))
                let progress = goldkeyCount / Float(goldkeyAmountPerLevel)

                mainView.goldKeyProgressBar.setProgress(progress, animated: false)
                mainView.goldKeyCountingLabel.text = "\(Int(goldkeyCount))/\(goldkeyAmountPerLevel)"
                mainView.goldKeyTitleLabel.text = "나의 홀리 레벨 Lv.\(level)"

                return (goldkey, level)
            }

        let delayShowGoldkeyMessageTime = Observable.merge(viewDidAppear, willEnterForeground)
            .flatMap { _ -> Observable<Int> in
                Observable<Int>.timer(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            }

        delayShowGoldkeyMessageTime
            .withLatestFrom(goldkeyMessageObservable) { ($0, $1) }
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] (_, values) in
                self?.didChangeGoldkeyValue(values)
            })
            .disposed(by: disposeBag)

        videoListViewModel.output.selectionVideo
            .asObservable()
            .map { result in
                switch result.kind {
                case
                }
            }
            .drive()
            .disposed(by: disposeBag)
    }
    
    func bindMainViewModel() {
        mainView.myPageButton.rx.action = viewModel.didTapMyPage()
        mainView.qrPageButton.rx.action = viewModel.didTapQR()

        mainView.profileView.imageViewTapped
            .withUnretained(self)
            .subscribe(onNext: { (owner, _) in
                owner.viewModel.input.profileTap.onNext(())
            })
            .disposed(by: rx.disposeBag)

        viewWillAppear
            .compactMap { $0 }
            .take(1)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] _ in
                mainView.goldKeyMessageLabel.text = "홀리랜드에서 예배하면 금키를 모을 수 있어요!"
            })
            .disposed(by: disposeBag)

        viewWillAppear
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [unowned self] _ in
                mainView.setAppbarImage(with: Date())
            })
            .disposed(by: disposeBag)
    }
}

extension MainViewController {
    func setupViews() {
        view = mainView
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        setupNavigationBackgroundColor(Asset.Color.lemon.color)
    }
    
    func showUnableToWorshipAlert() {
        self.view.showAlertView(type: .cannotServiceWorship)
    }

    func showGoldkeyObtainmentToastView(with goldkey: Int) {
        self.view.showToastView(message: "금키를 \(goldkey)개 획득했어요!")
    }

    func showLevelUpToastView(previous: Int, current: Int) {
        let levelUpToastView = UserLevelUpToastView(frame: self.view.frame)
        self.view.addSubview(levelUpToastView)
        levelUpToastView.removeCompletion = levelUpToastView.removeFromSuperview
        levelUpToastView.showWithLevel(previous: previous, current: current)
        levelUpToastView.remove(timeInterval: 4)
    }
}

private extension MainViewController {
    func didChangeGoldkeyValue(_ value: (goldkey: Int, level: Int)) {
        let goldkey = value.goldkey
        let level = value.level

        if lastHolyLevel != level {
            showLevelUpToastView(previous: lastHolyLevel, current: level)
            lastHolyLevel = level
            lastGoldkey = goldkey
        } else {
            guard lastGoldkey != goldkey else { return }
            let obtainedGoldkey = goldkey - lastGoldkey
            lastGoldkey = goldkey
            showGoldkeyObtainmentToastView(with: obtainedGoldkey)
        }
    }
}

extension MainViewController {
    func getVideoListViewModel() -> VideoListViewModel? {
        guard let viewModel = self.videoListViewModel else { return nil }

        goldkeyViewModel.obtainableGoldKeys
            .map { (obtainableGoldKeyInfo) -> [VideoInformation] in
                return [VideoInformation(kind: .vimeo(type: .day), viewable: obtainableGoldKeyInfo?.weekDay),
                        VideoInformation(kind: .vimeo(type: .night), viewable: obtainableGoldKeyInfo?.weekNight),
                        VideoInformation(kind: .vimeo(type: .live)),
                        VideoInformation(kind: .youtube(type: .earlyLoveBible)),
                        VideoInformation(kind: .youtube(type: .firePillarBible)),
                        VideoInformation(kind: .youtube(type: .morningTreatBible))]
            }
            .bind(to: viewModel.input.videoInfomations)
            .disposed(by: disposeBag)

        return viewModel
    }
}
