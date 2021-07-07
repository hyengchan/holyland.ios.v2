//
//  UserDataSource.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/15.
//

import Foundation
import RxSwift

final class UserDataSourceImpl: UserDataSource {
    func userInfo(idx: String) -> Observable<User?> {
        return NetworkClient.userInfo(idx: idx)
            .asObservable()
            .flatMap { result -> Observable<User?> in
                switch result {
                case .success(let user):
                    return Observable.just(user)
                case .error(let error):
                    return Observable.error(error)
                }
            }
    }
    
    func siginIn(idx: String, password: String) -> Observable<Int?> {
        return NetworkClient.signIn(idx: idx, password: password)
            .asObservable()
    }
    
    func updatePhoto(idx: String, imageData: Data?) -> Observable<String?> {
        return NetworkClient.updateUserProfilePhoto(idx: idx, imageData: imageData)
            .asObservable()
    }
    
    func updateEmotion(idx: Int, emotion: Int) -> Observable<Bool> {
        return NetworkClient.updateUserEmotion(idx: idx, emotion: emotion)
            .asObservable()
    }
    
    func updatePassword(idx: Int, current: String, new: String) -> Observable<Bool> {
        return NetworkClient.updateUserPassword(idx: "\(idx)", current: current, new: new)
            .asObservable()
    }
    
    func attendances(idx: String) -> Observable<[Attendance]> {
        return NetworkClient.userAttendances(idx: idx)
            .asObservable()
            .flatMap { result -> Observable<[Attendance]> in
                switch result {
                case .success(let attendances):
                    return Observable.just(attendances)
                case .error:
                    return Observable.just([])
                }
            }
    }
    
    func childs(classIdx: Int) -> Observable<[User]> {
        return NetworkClient.childs(classIdx: classIdx)
            .asObservable()
            .flatMap { result -> Observable<[User]> in
                switch result {
                case .success(let childs):
                    return Observable.just(childs)
                case .error:
                    return Observable.just([])
                }
            }
    }
    
    func allChilds() -> Observable<[User]> {
        return NetworkClient.allChilds()
            .asObservable()
            .flatMap { result -> Observable<[User]> in
                switch result {
                case .success(let childs):
                    return Observable.just(childs)
                case .error:
                    return Observable.just([])
                }
            }
    }
}
