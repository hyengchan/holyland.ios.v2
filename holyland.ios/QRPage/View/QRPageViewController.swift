//
//  QRPageViewController.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/02.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class QRPageViewController: BaseViewController {

    var viewModel: QRPageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAlls()
        bind()
    }
}

// MARK: Bindings
extension QRPageViewController {
    func bind() {
        navigationFirstButtonSelectedCompletion = { [unowned self] in
            viewModel.output.backTap.onNext(())
            return Observable.empty()
        }
    }
}

// MARK: UIs
extension QRPageViewController {
    func setAlls() {
        setView()
        setNaviBar()
    }

    func setView() {
        view.backgroundColor = .white
    }

    func setNaviBar() {
        setupNavigationBackgroundColor(Asset.Color.lemon.color)
        setupNavigationButton(navigationFirstButton, image: Asset.Assets.btnClose.image)
    }
}
