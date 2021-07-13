//
//  UserRepository2.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//
import RxSwift
import RxRelay

protocol UserRepository {
    func siginIn(credentials: Credentials) -> Observable<Result<Int, Error>>
    func userInfo(idx: Int) -> Observable<Result<User, Error>>
    @discardableResult
    func saveUser(_ user: User) -> Observable<Void>
}
