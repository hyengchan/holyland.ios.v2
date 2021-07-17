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
import NSObject_Rx

class MyProfileViewController: BaseViewController {

    var viewModel: MyProfileViewModel!
    var userViewModel: UserViewModel!

    lazy var myProfileView = MyProfileView(frame: self.view.frame)

    private var userObservable: Observable<User> {
        userViewModel.loginUser.compactMap { $0 }.share()
    }

    var emotions = Emotion.allCases

    override func viewDidLoad() {
        super.viewDidLoad()

        setAlls()
        bind()
        bindingCollectionView()
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

    func bindingCollectionView() {
        Observable.of(emotions)
            .bind(to: myProfileView.emotionCollectionView.collectionView.rx.items(cellIdentifier: EmotionCollectionViewCell.identifier,
                                                                                  cellType: EmotionCollectionViewCell.self)) { (_, element, cell) in
                print(cell)
                cell.configure(image: element.image, title: element.description)
            }
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - UIs
extension MyProfileViewController {
    func setAlls() {
        setView()
    }

    func setView() {
        view.backgroundColor = .white
        view = myProfileView

        setNaviBar()
    }

    func setNaviBar() {
        setupNavigationTitle("프로필 바꾸기")

        setupNavigationButton(navigationFirstButton, image: Asset.Assets.btnBack.image)
        setupNavigationButton(navigationLastButton, image: Asset.Assets.btnSaveOn.image)

        navigationLastButton.setImage(Asset.Assets.btnSaveOff.image, for: .disabled)
    }
}
