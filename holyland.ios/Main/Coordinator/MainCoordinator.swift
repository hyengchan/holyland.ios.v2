//
//  MainCoordinator.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/23.
//

import UIKit
import RxSwift
import Swinject
import NSObject_Rx

class MainCoordinator: BaseCoordinator<Void> {

    private var navigationController: UINavigationController
    private let container: Container

    init(container: Container, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.container = container
    }

    override func start() -> Observable<Void> {
        let vc = container.resolve(MainViewController.self)!
        navigationController.pushViewController(vc, animated: true)

        vc.viewModel.input.myPageTap
            .flatMap { [unowned self] in
                coordinate(to: MyPageCoordinator(container: container, navigationController: navigationController))
            }
            .subscribe()
            .disposed(by: rx.disposeBag)

        vc.viewModel.input.qrPageTap
            .flatMap { [unowned self] in
                coordinate(to: QRPageCoordinator(container: container, navigationController: navigationController))
            }
            .subscribe()
            .disposed(by: rx.disposeBag)

        vc.viewModel.input.profileTap
            .subscribe( { _ in print("ButtonTapped") })
            .disposed(by: rx.disposeBag)

        return Observable.never()
    }
}
