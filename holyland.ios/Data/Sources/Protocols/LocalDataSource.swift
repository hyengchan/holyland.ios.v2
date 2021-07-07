//
//  LocalDataSource.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/30.
//
import RxSwift
import Foundation

protocol LocalDataSource {
    func saveUser(_ user: User) -> Single<User>
    func deleteUser(idx: Int) -> Single<Bool>
    func updateSignedInDate(of user: User, _ date: Date) -> Single<Void>
}
