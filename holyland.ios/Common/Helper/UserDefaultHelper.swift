//
//  UserDefaultHelper.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/17.
//

import UIKit
import RxSwift
import RxCocoa

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}

struct UserPersistentStorage {
    @UserDefault(key: "loggedInIdx", defaultValue: nil)
    static var loggedInIdx: Int?
}
