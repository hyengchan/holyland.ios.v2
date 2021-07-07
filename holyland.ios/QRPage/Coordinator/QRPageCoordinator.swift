//
//  QRPageCoordinator.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/02.
//

import RxSwift
import Swinject
import NSObject_Rx

class QRPageCoordinator: BaseCoordinator<Void> {

    private var navigationController: UINavigationController
    private let container: Container

    init(container: Container, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.container = container
    }

    override func start() -> Observable<Void> {
        let vc = container.resolve(QRPageViewController.self)!
        navigationController.pushViewController(vc, animated: true)

        vc.viewModel.output.backTap
            .take(1)
            .map { [unowned self] in
                navigationController.popViewController(animated: true)
            }
            .subscribe()
            .disposed(by: disposeBag)

        return Observable.never()
    }
}
