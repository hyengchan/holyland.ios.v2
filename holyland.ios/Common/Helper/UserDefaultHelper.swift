//
//  UserDefaultHelper.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/17.
//

import UIKit
import RxSwift
import RxCocoa

final class UserDefaultsHelper {
    static func setData<T>(value: T, key: UserDefaultKeys) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key.rawValue)
    }
    
    static func getData<T>(type: T.Type, forKey key: UserDefaultKeys) -> Observable<T?> {
        let defaults = UserDefaults.standard
        return defaults.rx.observe(T.self, key.rawValue)
    }
    
    static func getData2<T>(type: T.Type, forKey key: UserDefaultKeys) -> T? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: key.rawValue) as? T
    }
    
    static func removeData(key: UserDefaultKeys) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key.rawValue)
    }
}

enum UserDefaultKeys: String, CaseIterable {
    case loggedInIdx // 현재 로그인한 사용자의 idx
    case shouldDeletedWhenSignOut
}
