//
//  UserLocalStorage.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//

import RealmSwift
import RxSwift

protocol UserLocalDataSouce {
    @discardableResult func saveUser(_ user: StorableUser) -> Completable
    @discardableResult func deleteUser(idx: Int) -> Completable
}

final class RealmUserStorage: RealmStorageProtocol, UserLocalDataSouce {
    typealias RealmModel = StorableUser

    let instance: Realm

    init(instance: Realm) {
        self.instance = instance
    }

    @discardableResult
    func saveUser(_ user: StorableUser) -> Completable {
        Completable.create { completable in
            switch self.save(user) {
            case .success:
                completable(.completed)
            case .failure(let error):
                completable(.error(error))
            }
            return Disposables.create { }
        }
    }

    @discardableResult
    func deleteUser(idx: Int) -> Completable {
        Completable.create { completable in
            if let user = try? self.get(predicate: NSPredicate(format: "idx == %d", NSNumber(value: idx))).get() {
                switch self.delete(user) {
                case .success:
                    completable(.completed)
                case .failure(let error):
                    completable(.error(error))
                }
            } else {
                completable(.error(RealmError.invalidObject))
            }
            return Disposables.create { }
        }
    }
}
