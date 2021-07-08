//
//  User+.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/11.
//

import Foundation
import UIKit

extension User {
    var isChild: Bool { self.userLevel == 5 }
    
    var classIdx: Int? {
        if classDayInfo.id < 9999 {
            return classDayInfo.id
        } else if classNightInfo.id > 9999 {
            return classNightInfo.id
        } else {
          return nil
        }
    }
    
    var nameWithChurchDuties: String {
        switch userLevel {
        case 0:
            return name + "목사님"
        case 1:
            return name + "전도사님"
        case 2:
            return name + "팀장님"
        case 3:
            return name + "부장님"
        case 4:
            return name + "선생님"
        default:
            return name
        }
    }
    
    var className: String {
        switch userLevel {
        case 0:
            return "금란교회 아동부 목사님"
        case 4:
            return dropClassTeacherName  // 본인 이름 제외
        case 5:
            return classTeacherName // 선생님 이름만 표시
        default:
            return defaultClassName
        }
    }
    
    var defaultClassName: String {
        !classDayInfo.name.isEmpty ? classDayInfo.name : classNightInfo.name
    }
    
    var classTeacherName: String {
        splitClassName().last ?? defaultClassName
    }
    
    var classDepartmentName: String? {
        splitClassName().first
    }
    
    var dropClassTeacherName: String {
        var classNames = splitClassName()
        guard classNames.count > 1 else {
            return defaultClassName
        }
        classNames.removeLast()
        return classNames.joined()
    }
}

extension User {
    
    enum ClassType {
        case none
        case day
        case night
    }
    
    static func classType(idx: Int) -> ClassType {
        if idx < 9999 {
            return .day
        } else if idx > 9999 {
            return .night
        } else {
            return .none
        }
    }
    
    static func basicProfilePhoto(by gender: Gender) -> UIImage? {
        gender == .male ? UIImage(named: "icBasicProfileBoy") : UIImage(named: "icBasicProfileGirl")
    }
    
    // MARK: - Private
    private func splitClassName() -> [String] {
        defaultClassName.components(separatedBy: " ")
    }
}
