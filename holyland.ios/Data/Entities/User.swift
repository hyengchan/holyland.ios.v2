//
//  User.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/10.
//

import Foundation
import RealmSwift

class User: Object, Decodable {
    @objc dynamic var idx = 0
    @objc dynamic var userName = ""
    @objc dynamic var userBirth = ""
    @objc dynamic var userMobile = ""
    @objc dynamic var photoURLPath = ""
    @objc dynamic var userGender = false
    @objc dynamic var emotion = 0
    @objc dynamic var userLevel = 0
    @objc dynamic var holyLevel = 0
    @objc dynamic var goldkeyTotal = 0
    @objc dynamic var classDay = 0
    @objc dynamic var classNight = 0
    @objc dynamic var classDayStr = ""
    @objc dynamic var classNightStr = ""
    @objc dynamic var regDate = ""
    @objc dynamic var classStr = ""
    @objc dynamic var signedInDate = Date()
    
    let dayTeachers = List<Teacher>()
    let nightTeachers = List<Teacher>()
    
    override static func primaryKey() -> String? {
        return "idx"
    }
    
    private enum CodingKeys: String, CodingKey {
        case idx
        case emotion
        case photoURLPath = "photo"
        case userName = "uname"
        case userGender = "usex"
        case userBirth = "ubirth"
        case userMobile = "umobile"
        case userLevel = "ulevel"
        case classDay = "class_day"
        case classNight = "class_night"
        case classDayStr = "class_day_str"
        case classNightStr = "class_night_str"
        case goldkeyTotal = "goldkey_total"
        case holyLevel = "holylevel"
        case regDate = "reg_date"
        case classStr = "class_str"
        case dayTeachers = "teachers_day"
        case nightTeachers = "teachers_night"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.idx = try container.decode(Int.self, forKey: .idx)
        self.userName = try container.decode(String.self, forKey: .userName)
        self.userLevel = try container.decode(Int.self, forKey: .userLevel)
        self.classDay = try container.decodeIfPresent(Int.self, forKey: .classDay) ?? 0
        self.classNight = try container.decodeIfPresent(Int.self, forKey: .classNight) ?? 0
        self.userBirth = try container.decodeIfPresent(String.self, forKey: .userBirth) ?? ""
        self.classDayStr = try container.decodeIfPresent(String.self, forKey: .classDayStr) ?? ""
        self.classNightStr = try container.decodeIfPresent(String.self, forKey: .classNightStr) ?? ""
        self.goldkeyTotal = try container.decodeIfPresent(Int.self, forKey: .goldkeyTotal) ?? 0
        self.holyLevel = try container.decodeIfPresent(Int.self, forKey: .holyLevel) ?? 0
        self.classStr = try container.decodeIfPresent(String.self, forKey: .classStr) ?? ""
        self.photoURLPath = try container.decodeIfPresent(String.self, forKey: .photoURLPath) ?? ""
        self.emotion = try container.decodeIfPresent(Int.self, forKey: .emotion) ?? 0
        self.userGender = try container.decodeIfPresent(Bool.self, forKey: .userGender) ?? false
        self.userMobile = try container.decodeIfPresent(String.self, forKey: .userMobile) ?? ""
        self.regDate = try container.decodeIfPresent(String.self, forKey: .regDate) ?? ""
        
        let dayTeachers = try container.decodeIfPresent([Teacher].self, forKey: .dayTeachers) ?? []
        self.dayTeachers.append(objectsIn: dayTeachers)
        
        let nightTeachers = try container.decodeIfPresent([Teacher].self, forKey: .nightTeachers) ?? []
        self.nightTeachers.append(objectsIn: nightTeachers)
    }
}
