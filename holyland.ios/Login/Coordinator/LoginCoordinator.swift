//
//  LoginCoordinator.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/22.
//

import UIKit
import RxSwift
import Swinject
import NSObject_Rx

class LoginCoordinator: BaseCoordinator<Void> {
    private var navigationController: UINavigationController
    
    let container: Container
    
    init(navigationController: UINavigationController,
         container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    override func start() -> Observable<Void> {
        let vc = container.resolve(LoginViewController.self)!
        navigationController.viewControllers = [vc]

        vc.viewModel.output.resultSubject
            .flatMap { [unowned self] _ in
                coordinate(to: MainCoordinator(container: container, navigationController: navigationController))
            }
            .subscribe()
            .disposed(by: rx.disposeBag)
        
        return Observable.never()
    }
}
