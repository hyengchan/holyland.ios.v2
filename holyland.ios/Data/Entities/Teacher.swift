//
//  Teacher.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/10.
//

import Foundation
import RealmSwift

class Teacher: Object, Decodable {
    @objc dynamic var idx = 0
    @objc dynamic var userName = ""
    @objc dynamic var userMobile = ""
    @objc dynamic var className = ""
    @objc dynamic var userLevel = 0
    @objc dynamic var classIdx = 0
    
    let dayTeachers = LinkingObjects(fromType: User.self, property: "dayTeachers")
    let nightTeachers = LinkingObjects(fromType: User.self, property: "nightTeachers")
    
    override static func primaryKey() -> String? {
        return "idx"
    }
    
    private enum CodingKeys: String, CodingKey {
        case idx
        case userName = "uname"
        case userMobile = "umobile"
        case userLevel = "ulevel"
        case classIdx = "class_idx"
        case className = "cname"
    }
}

extension Teacher {
    var isMain: Bool {
        className == userName
    }
}
