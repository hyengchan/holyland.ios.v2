//
//  AppDelegate+Swinject.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/17.
//

import Foundation
import Swinject
import RealmSwift

extension AppDelegate {
    internal func setupDependencies() {
//        
//        container.register(SceneCoordinatorType.self) { _ in
//            SceneCoordinator(window: self.window!)
//        }
//        .inObjectScope(ObjectScope.container)
        
        // MARK: - Persistant storage
        container.register(Realm.Configuration.self) { _ in
            Realm.Configuration()
        }
        .inObjectScope(ObjectScope.container)

        container.register(Realm.self) { resolver in
            try! Realm(configuration: resolver.resolve(Realm.Configuration.self)!)
        }
        .inObjectScope(ObjectScope.container)

        // MARK: - DataSources
        container.register(LocalDataSource.self) { resolver in
            LocalDataSourceImpl(realm: resolver.resolve(Realm.self)!)
        }
        .inObjectScope(ObjectScope.container)
        
        container.register(UserDataSource.self) { _ in
            UserDataSourceImpl()
        }
        .inObjectScope(ObjectScope.container)
        
        // MARK: - Repositories
        container.register(UserRepository.self) { resolver in
            UserRepositoryImpl(userDataSource: resolver.resolve(UserDataSource.self)!,
                               localDataSource: resolver.resolve(LocalDataSource.self)!)
        }
        .inObjectScope(ObjectScope.container)
        
        // MARK: - ViewModels
        container.register(LoginViewModel.self) { resolver in
            LoginViewModel(userRepository: resolver.resolve(UserRepository.self)!,
                           container: self.container)
        }
        .inObjectScope(ObjectScope.container)
        
        container.register(MainViewModel.self) { resolver in
            MainViewModel(userRepository: resolver.resolve(UserRepository.self)!,
                          container: self.container)
        }
        .inObjectScope(ObjectScope.container)

        container.register(MyPageViewModel.self) { _ in
            MyPageViewModel(container: self.container)
        }

        container.register(QRPageViewModel.self) { _ in
            QRPageViewModel(container: self.container)
        }
        .inObjectScope(ObjectScope.container)

        container.register(VideoListViewModel.self) { _ in
            VideoListViewModel()
        }
        .inObjectScope(ObjectScope.container)
        
        // MARK: - ViewControllers
        container.register(LoginViewController.self) { resolver in
            let viewController = LoginViewController()
            viewController.viewModel = resolver.resolve(LoginViewModel.self)
            return viewController
        }
        
        container.register(MainViewController.self) { resolver in
            let viewController = MainViewController()
            viewController.viewModel = resolver.resolve(MainViewModel.self)
            viewController.videoListModel = resolver.resolve(VideoListViewModel.self)
            return viewController
        }

        container.register(MyPageViewController.self) { resolver in
            let viewController = MyPageViewController()
            viewController.viewModel = resolver.resolve(MyPageViewModel.self)
            return viewController
        }

        container.register(QRPageViewController.self) { resolver in
            let viewController = QRPageViewController()
            viewController.viewModel = resolver.resolve(QRPageViewModel.self)
            return viewController
        }
    }
}
