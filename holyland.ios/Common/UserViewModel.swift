//
//  UserViewModel.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/15.
//

import Foundation
import RxSwift

class UserViewModel {
    var user = BehaviorSubject<User?>(value: nil)
}
