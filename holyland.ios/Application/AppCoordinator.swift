//
//  AppCoordinator.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/22.
//

import UIKit
import Swinject
import RxSwift

final class AppCoordinator: BaseCoordinator<Void> {

    enum State {
        case requiredSignInWithNewAccount
        case stilSignedIn(idx: Int)
        case havePreviouslySignedInUsers
    }

    private let window: UIWindow
    private var navigationController: UINavigationController
    let container: Container

    init(window: UIWindow,
         container: Container,
         navigationController: UINavigationController) {
        self.window = window
        self.container = container
        self.navigationController = navigationController
    }

    override func start() -> Observable<Void> {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return self.coordinate(to: LoginCoordinator(navigationController: navigationController, container: container))
    }
}
