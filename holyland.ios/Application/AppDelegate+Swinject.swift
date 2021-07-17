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
        container.register(UserLocalDataSouce.self) { resolver in
            RealmUserStorage(instance: resolver.resolve(Realm.self)!)
        }

        container.register(UserRemoteDataSource.self) { _ in
            UserRemoteDataSourceImpl()
        }

        container.register(GoldKeyDataSource.self) { _ in
            GoldKeyDataSourceImpl()
        }

        // MARK: - Repositories
        container.register(UserRepository.self) { resolver in
            UserRepositoryImpl(userDataSource: resolver.resolve(UserRemoteDataSource.self)!,
                               localDataSource: resolver.resolve(UserLocalDataSouce.self)!)
        }
        .inObjectScope(ObjectScope.container)

        container.register(GoldKeyRepository.self) { resolver in
            GoldKeyRepositoryImpl(goldKeyDataSource: resolver.resolve(GoldKeyDataSource.self)!)
        }
        
        // MARK: - ViewModels
        container.register(UserViewModel.self) { resolver in
            UserViewModel(userRepository: resolver.resolve(UserRepository.self)!)
        }
        .inObjectScope(ObjectScope.container)

        container.register(GoldKeyViewModel.self) { resolver in
            GoldKeyViewModel(goldkeyRepository: resolver.resolve(GoldKeyRepository.self)!)
        }
        .inObjectScope(ObjectScope.container)

        container.register(LoginViewModel.self) { resolver in
            LoginViewModel(userRepository: resolver.resolve(UserRepository.self)!,
                           container: self.container)
        }
        .inObjectScope(ObjectScope.container)
        
        container.register(MainViewModel.self) { resolver in
            MainViewModel(goldKeyRepository: resolver.resolve(GoldKeyRepository.self)!,
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

        container.register(MyProfileViewModel.self) { _ in
            MyProfileViewModel(container: self.container)
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
            viewController.userViewModel = resolver.resolve(UserViewModel.self)
            viewController.goldkeyViewModel = resolver.resolve(GoldKeyViewModel.self)
            viewController.videoListViewModel = resolver.resolve(VideoListViewModel.self)
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

        container.register(MyProfileViewController.self) { resolver in
            let viewController = MyProfileViewController()
            viewController.viewModel = resolver.resolve(MyProfileViewModel.self)
            viewController.userViewModel = resolver.resolve(UserViewModel.self)
            return viewController
        }
    }
}
