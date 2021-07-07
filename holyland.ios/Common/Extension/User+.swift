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
    
    var gender: Gender { userGender ? .female : .male }
    
    var classIdx: Int? {
        if classDay < 9999 {
            return classDay
        } else if classNight > 9999 {
            return classNight
        } else {
          return nil
        }
    }
    
    var nameWithChurchDuties: String {
        switch userLevel {
        case 0:
            return userName + "목사님"
        case 1:
            return userName + "전도사님"
        case 2:
            return userName + "팀장님"
        case 3:
            return userName + "부장님"
        case 4:
            return userName + "선생님"
        default:
            return userName
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
        !classDayStr.isEmpty ? classDayStr : classNightStr
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
