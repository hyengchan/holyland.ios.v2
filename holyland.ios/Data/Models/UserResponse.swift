//
//  UserResponse.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//

import Foundation
import RealmSwift

public protocol DTO { }

// MARK: - Data Transfer Object
// Data Layer
struct UserResponse: Decodable, DTO {
    let idx: Int
    let name: String
    let birth: String
    let mobile: String
    let photoURL: String
    let gender: Bool
    let emotion: Int
    let userLevel: Int
    let holyLevel: Int
    let totalGoldkey: Int
    let classDay: Int
    let classNight: Int
    let classDayStr: String
    let classNightStr: String
    let regDate: String
    let dayTeachers: [TeacherResponse]
    let nightTeachers: [TeacherResponse]

    private enum CodingKeys: String, CodingKey {
        case idx
        case emotion
        case photoURL = "photo"
        case name = "uname"
        case gender = "usex"
        case birth = "ubirth"
        case mobile = "umobile"
        case userLevel = "ulevel"
        case classDay = "class_day"
        case classNight = "class_night"
        case classDayStr = "class_day_str"
        case classNightStr = "class_night_str"
        case totalGoldkey = "goldkey_total"
        case holyLevel = "holylevel"
        case regDate = "reg_date"
        case dayTeachers = "teachers_day"
        case nightTeachers = "teachers_night"
    }
}

struct TeacherResponse: Decodable, DTO {
    let idx: Int
    let userName: String
    let userMobile: String
    let className: String
    let classIdx: Int
    let userLevel: Int

    private enum CodingKeys: String, CodingKey {
        case idx
        case userName = "uname"
        case userMobile = "umobile"
        case userLevel = "ulevel"
        case classIdx = "class_idx"
        case className = "cname"
    }
}
