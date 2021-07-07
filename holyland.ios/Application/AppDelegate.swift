//
//  AppDelegate.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/01.
//

import UIKit
import Swinject
import RxSwift
import Firebase
import FirebaseMessaging
import UserNotifications
import NSObject_Rx

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    internal let container = Container()
    private var appCoordinator: AppCoordinator!
    let navigationController = UINavigationController()
    
    func application(_: UIApplication,
                     willFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        setupDependencies()
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = UINavigationController()

//        FirebaseApp.configure()
//        Messaging.messaging().delegate = self
//        UNUserNotificationCenter.current().delegate = self
//        application.registerForRemoteNotifications()

//        let coordinator = container.resolve(SceneCoordinatorType.self)!
//        let loginScene = Scene.login(container.resolve(LoginViewModel.self)!)
//
//        coordinator.transition(to: loginScene, using: .root, animated: false)

        appCoordinator = AppCoordinator(window: window!, container: container, navigationController: navigationController)
        appCoordinator.start()
            .subscribe()
            .disposed(by: rx.disposeBag)

        return true
        
    }
}
