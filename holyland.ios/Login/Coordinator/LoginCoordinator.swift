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

        vc.viewModel.output.resultSubject
            .drive(with: self, onNext: { owner, _ in
                owner.coordinate(to: MainCoordinator(container: owner.container, navigationController: owner.navigationController))
            })
            .disposed(by: rx.disposeBag)

        navigationController.viewControllers = [vc]
        
        return Observable.never()
    }
}
