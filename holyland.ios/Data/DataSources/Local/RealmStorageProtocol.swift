//
//  RealmStorageProtocol.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//

import Foundation
import RxSwift
import RealmSwift

enum RealmError: Error {
    case invalidObject
}

protocol RealmStorageProtocol {
    associatedtype RealmModel: Object

    var instance: Realm { get }

    init(instance: Realm)

    func get(predicate: NSPredicate?) -> Result<RealmModel, Error>
    func getAll(predicate: NSPredicate?) -> Result<[RealmModel], Error>
    func save(_ item: RealmModel) -> Result<Void, Error>
    func delete(_ item: RealmModel) -> Result<Void, Error>
    func update(_ block: () -> Void) -> Result<Void, Error>

}

extension RealmStorageProtocol {
    func get(predicate: NSPredicate? = nil) -> Result<RealmModel, Error> {
        var object = instance.objects(RealmModel.self)

        if let predicate = predicate {
            object = object.filter(predicate)
        }

        guard let model = object.compactMap({ $0 }).first else {
            return .failure(RealmError.invalidObject)
        }
        return .success(model)
    }

    func getAll(predicate: NSPredicate? = nil) -> Result<[RealmModel], Error> {
        var object = instance.objects(RealmModel.self)

        if let predicate = predicate {
            object = object.filter(predicate)
        }

        return .success(object.toArray(type: RealmModel.self))
    }

    func save(_ item: RealmModel) -> Result<Void, Error> {
        do {
            try instance.write {
                instance.add(item, update: .modified)
            }
            return .success(Void())
        } catch let error {
            return .failure(error)
        }
    }

    func delete(_ item: RealmModel) -> Result<Void, Error> {
        do {
            try instance.write {
                let object = instance.objects(RealmModel.self)
                instance.delete(object, cascading: true)
            }

            return .success(Void())
        } catch let error {
           return .failure(error)
        }
    }

    func update(_ block: () -> Void) -> Result<Void, Error> {
        do {
            try instance.write(block)
            return .success(Void())
        } catch let error {
            return .failure(error)
        }
    }
}
