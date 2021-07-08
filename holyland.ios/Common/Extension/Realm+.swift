//
//  Realm+.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/17.
//

import RealmSwift
import Realm

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}

protocol CascadeDeleting {
    func delete<S: Sequence>(_ objects: S, cascading: Bool) where S.Iterator.Element: Object
    func delete<Entity: Object>(_ entity: Entity, cascading: Bool)
}

extension Realm: CascadeDeleting {
    func delete<S: Sequence>(_ objects: S, cascading: Bool) where S.Iterator.Element: Object {
        for obj in objects {
            delete(obj, cascading: cascading)
        }
    }
    
    func delete<Entity: Object>(_ entity: Entity, cascading: Bool) {
        if cascading {
            cascadeDelete(entity)
        } else {
            delete(entity)
        }
    }
}

private extension Realm {
    private func cascadeDelete(_ entity: RLMObjectBase) {
        guard let entity = entity as? Object else { return }
        var toBeDeleted = Set<RLMObjectBase>()
        toBeDeleted.insert(entity)
        while !toBeDeleted.isEmpty {
            guard let element = toBeDeleted.removeFirst() as? Object,
                !element.isInvalidated else { continue }
            resolve(element: element, toBeDeleted: &toBeDeleted)
        }
    }
    
    private func resolve(element: Object, toBeDeleted: inout Set<RLMObjectBase>) {
        element.objectSchema.properties.forEach {
            guard let value = element.value(forKey: $0.name) else { return }
            if let entity = value as? RLMObjectBase {
                toBeDeleted.insert(entity)
            } else if let list = value as? RealmSwift.ListBase {
                for index in 0 ..< list._rlmArray.count {
                    if let realmObject = list._rlmArray.object(at: index) as? RLMObjectBase {
                        toBeDeleted.insert(realmObject)
                    }
                }
            }
        }
        delete(element)
    }
}

extension Results{
    func get <T:Object> (offset: Int, limit: Int ) -> Array<T>{
        var lim = 0 // how much to take
        var off = 0 // start from
        var l: Array<T> = Array<T>() // results list

        //check indexes
        if off<=offset && offset<self.count - 1 {
            off = offset
        }
        if limit > self.count {
            lim = self.count
        }else{
            lim = limit
        }

        //do slicing
        for i in off..<lim{
            let item = self[i] as! T
            l.append(item)
        }

        return l
    }
}
