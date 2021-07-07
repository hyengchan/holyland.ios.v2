//
//  LocalDataSourceImpl.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/15.
//

import Foundation
import RxSwift
import RealmSwift

final class LocalDataSourceImpl: LocalDataSource {
    private let realm: Realm

    init(realm: Realm) {
        self.realm = realm
    }
    
    func saveUser(_ user: User) -> Single<User> {
        do {
            try realm.write {
                realm.add(user, update: .modified)
            }
            return Observable.just(user).asSingle()
        } catch let error {
           return Observable.error(error).asSingle()
        }
    }
    
    func deleteUser(idx: Int) -> Single<Bool> {
        do {
            try realm.write {
                let object = realm.objects(User.self).filter("idx = %@", idx)
                realm.delete(object, cascading: true)
            }
            
            return Single.just(true)
        } catch let error {
           return Single.error(error)
        }
    }
    
    func updateSignedInDate(of user: User, _ date: Date) -> Single<Void> {
        do {
            try realm.write {
                user.signedInDate = date
            }
            return Single.just(())
        } catch let error {
            return Single.error(error)
        }
    }
}
