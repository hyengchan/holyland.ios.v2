//
//  MyProfileViewController.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/13.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class MyProfileViewController: BaseViewController {

    var viewModel: MyProfileViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setAlls()
        bind()
    }
}

// MARK: - Binding
extension MyProfileViewController {
    func bind() {
        navigationFirstButtonSelectedCompletion = { [unowned self] in
            viewModel.output.backTap.onNext(())
            return Observable.empty()
        }
    }
}

// MARK: - UIs
extension MyProfileViewController {
    func setAlls() {
        setView()
        setNaviBar()
    }

    func setView() {
        view.backgroundColor = .white
    }

    func setNaviBar() {
        //setupNavigationBackgroundColor(Asset.Color.lemon.color)
        setupNavigationButton(navigationFirstButton, image: Asset.Assets.btnBack.image)
        setupNavigationButton(navigationLastButton, image: Asset.Assets.btnSaveOn.image)
        setupNavigationTitle("프로필 바꾸기")
    }
}
