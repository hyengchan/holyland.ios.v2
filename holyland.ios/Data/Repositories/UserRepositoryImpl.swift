//
//  UserRepositoryImpl.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/15.
//

import Foundation
import RxSwift
import RxCocoa

final class UserRepositoryImpl: UserRepository {
    
    private let userDataSource: UserDataSource
    private let localDataSource: LocalDataSource
    
    private(set) var user: BehaviorRelay<User?> = BehaviorRelay<User?>(value: nil)
    
    init(userDataSource: UserDataSource,
         localDataSource: LocalDataSource) {
        self.userDataSource = userDataSource
        self.localDataSource = localDataSource
    }
    
    func saveUser(_ user: User) -> Observable<User> {
        self.localDataSource.saveUser(user).asObservable()
    }
    
    func deleteUser(_ user: User) -> Observable<Bool> {
        self.localDataSource.deleteUser(idx: user.idx)
            .asObservable()
            .catchAndReturn(false)
    }
    
    func siginIn(idx: String, password: String) -> Observable<Int?> {
        self.userDataSource.siginIn(idx: idx, password: password)
    }
    
    func userInfo(idx: Int) -> Observable<User?> {
        self.userDataSource.userInfo(idx: String(idx))
            .addSchedulers()
            .compactMap { $0 }
            .flatMap({ (user) -> Observable<User?> in
                return self.saveUser(user)
                    .do(onNext: { (user) in
                        _ = self.localDataSource.updateSignedInDate(of: user, Date())
                    })
                    .catchAndReturn(user)
                    .flatMap { (user) -> Observable<User?> in
                        self.user.accept(user)
                        return Observable.just(user)
                    }
            })
    }
    
    func updatePhoto(imageData: Data?) -> Observable<String?> {
        guard let userIdx = user.value?.idx else {
            return Observable.just(nil)
        }
        return self.userDataSource.updatePhoto(idx: "\(userIdx)", imageData: imageData)
    }
    
    func updateEmotion(_ emotion: Int) -> Observable<Bool> {
        guard let userIdx = user.value?.idx else {
            return Observable.just(false)
        }
        
        return self.userDataSource.updateEmotion(idx: userIdx, emotion: emotion)
    }
    
    func updatePassword(current: String, new: String) -> Observable<Bool> {
        guard let userIdx = user.value?.idx else {
            return Observable.just(false)
        }
        return userDataSource.updatePassword(idx: userIdx, current: current, new: new)
    }
    
    func attendances(idx: Int) -> Observable<[Attendance]> {
        userDataSource.attendances(idx: "\(idx)")
    }

    func initAll() {
        user.accept(nil)
    }
}
