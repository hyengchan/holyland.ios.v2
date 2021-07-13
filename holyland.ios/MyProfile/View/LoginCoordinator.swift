//
//  LoginCoordinator.swift
//  holyland.children
//
//  Created by 윤형찬 on 2021/07/13.
//

import UIKit
import RxSwift
import Swinject
import NSObject_Rx

class LoginCoordinator: BaseCoordinator<Void> {
    private var navigationController: UINavigationController
    private let container: Container

    init(navigationController: UINavigationController,
         container: Container) {
        self.navigationController = navigationController
        self.container = container
    }

    override func start() -> Observable<Void> {
        let vc = container.resolve(LoginViewController.self)!

        navigationController.viewControllers = [vc]

        return Observable.never()
    }
}
