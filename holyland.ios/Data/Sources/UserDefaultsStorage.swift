//
//  UserDefaultsStorage.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/17.
//

import RxSwift
import Foundation
import UIKit

final class UserDefaultsStorage {
    static func loggedInUserIdx() -> Observable<Int?> {
        UserDefaultsHelper.getData(type: Int.self, forKey: .loggedInIdx)
    }
    
    static func saveLoggedInUserIdx(_ idx: Int?) {
        UserDefaultsHelper.setData(value: idx, key: .loggedInIdx)
    }
    
    static func deleteLoggedInUserIdx() {
        UserDefaultsHelper.removeData(key: .loggedInIdx)
    }
    
    static func shouldDeletedWhenSignOut() -> Observable<Bool?> {
        UserDefaultsHelper.getData(type: Bool.self, forKey: .shouldDeletedWhenSignOut)
    }
    
    static func updateShouldDeletedWhenSignOut(with shouldDelete: Bool) {
        UserDefaultsHelper.setData(value: shouldDelete, key: .shouldDeletedWhenSignOut)
    }
}
