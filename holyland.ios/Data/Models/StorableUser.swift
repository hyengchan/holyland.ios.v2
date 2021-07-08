//
//  StorableUser.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//

import RealmSwift

public protocol Storable { }

// MARK: - Database Data Transfer Object
// Data Layer
class StorableUser: Object, Storable {
    @objc dynamic var idx = 0
    @objc dynamic var name = ""
    @objc dynamic var birth = ""
    @objc dynamic var phoneNumber = ""
    @objc dynamic var photoURL = ""
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

    let dayTeachers = List<StorableTeacher>()
    let nightTeachers = List<StorableTeacher>()

    override static func primaryKey() -> String? {
        return "idx"
    }
}

class StorableTeacher: Object, Storable {
    @objc dynamic var idx = 0
    @objc dynamic var userName = ""
    @objc dynamic var userMobile = ""
    @objc dynamic var className = ""
    @objc dynamic var classIdx = 0
    @objc dynamic var userLevel = 0

    let dayTeachers = LinkingObjects(fromType: StorableUser.self, property: "dayTeachers")
    let nightTeachers = LinkingObjects(fromType: StorableUser.self, property: "nightTeachers")

    override static func primaryKey() -> String? {
        return "idx"
    }
}
