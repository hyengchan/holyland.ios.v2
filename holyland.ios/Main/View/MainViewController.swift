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
    var videoListModel: VideoListViewModel!
    var videoCollectionView: VideoCollectionView!

    lazy var viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:))).mapToVoid().asObservable()
    lazy var userObservable = self.viewModel.output.user.compactMap { $0 }

    lazy var mainView = MainView(frame: self.view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        // swipe gesture 뒤로가기 금지
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        setupViews()
        bindMainViewModel()
    }

    func bindUserViewModel() {
        userObservable
            .take(1)
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [unowned self] _ in
                mainView.goldKeyTitleLabel.text = "집에서도 예배드려요!"
                mainView.goldKeyMessageLabel.text = "홀리랜드는 언제나 하나님과 연결되어 있어요!"
            })
            .disposed(by: disposeBag)
    }
    
    func bindMainViewModel() {
        mainView.myPageButton.rx.action = viewModel.didTapMyPage()
        mainView.qrPageButton.rx.action = viewModel.didTapQR()

        let tapGesture = UITapGestureRecognizer()
        mainView.profileView.addTapGestureToPhotoImageView(tapGesture)

        viewWillAppear
            .withLatestFrom(userObservable)
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [unowned self] user in
                mainView.profileView.configure(userPhotoURLPath: user.photoURLPath,
                                            gender: user.gender,
                                            emotion: user.emotion,
                                            userName: user.nameWithChurchDuties,
                                            className: user.className)
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
}
