//
//  UserEntity.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//

import Foundation

// MARK: - Entity
// Domain Layer

struct Genre {
    let id: Int
    let name: String
}

typealias ClassInfo = Genre

struct User: Entity {
    let id: Int
    let name: String
    let birth: String
    let phoneNumber: String
    let profileImage: String
    let gender: Gender
    let emotion: Emotion
    let userLevel: Int
    let holyLevel: Int
    let totalGoldkey: Int
    let classDayInfo: ClassInfo
    let classDayTeachers: [Teacher]
    let classNightInfo: ClassInfo
    let classNightTeachers: [Teacher]
    let registeredDate: Date?
    let signedInDate: Date?
}

struct Teacher: Entity {
    let id: Int
    let name: String
    let phoneNumber: String
    let classInfo: ClassInfo
    let userLevel: Int
}
