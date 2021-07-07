//
//  TestVC.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/01.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class MyPageViewController: BaseViewController {

    var viewModel: MyPageViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setAlls()
        bind()
    }
}

// MARK: - Binding
extension MyPageViewController {
    func bind() {
        navigationFirstButtonSelectedCompletion = { [unowned self] in
            viewModel.output.backTap.onNext(())
            return Observable.empty()
        }
    }
}

// MARK: - UIs
extension MyPageViewController {
    func setAlls() {
        setView()
        setNaviBar()
    }

    func setView() {
        view.backgroundColor = .white
    }

    func setNaviBar() {
        setupNavigationBackgroundColor(Asset.Color.lemon.color)
        setupNavigationButton(navigationFirstButton, image: Asset.Assets.btnHome.image)
        setupNavigationButton(navigationLastButton, image: Asset.Assets.btnSetting.image)
    }
}
