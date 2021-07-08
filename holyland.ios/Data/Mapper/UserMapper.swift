//
//  UserMapper.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//

import Foundation

protocol Mapper {
    associatedtype EntityType: Entity
    associatedtype DTOType: DTO
    associatedtype StorableType: Storable

    static func fromStorableObject(obj: StorableType) -> EntityType
    static func toStorableObject(entity: EntityType) -> StorableType
    static func fromNetworkResponseModel(dto: DTOType) -> EntityType
}

struct UserEntityMapper: Mapper {
    typealias EntityType = User
    typealias DTOType = UserResponse
    typealias StorableType = StorableUser

    static func fromStorableObject(obj: StorableType) -> EntityType {
        User(id: obj.idx,
             name: obj.name,
             birth: obj.birth,
             phoneNumber: obj.phoneNumber,
             profileImage: obj.photoURL,
             gender: Gender(value: obj.userGender),
             emotion: Emotion(value: obj.emotion),
             userLevel: obj.userLevel,
             holyLevel: obj.holyLevel,
             totalGoldkey: obj.goldkeyTotal,
             classDayInfo: ClassInfo(id: obj.classDay, name: obj.classDayStr),
             classDayTeachers: Array(obj.dayTeachers.map { TeacherEntityMapper.fromStorableObject(obj: $0) }),
             classNightInfo: ClassInfo(id: obj.classNight, name: obj.classNightStr),
             classNightTeachers: Array(obj.nightTeachers.map { TeacherEntityMapper.fromStorableObject(obj: $0) }),
             registeredDate: obj.regDate.toDate(),
             signedInDate: obj.signedInDate)
    }

    static func toStorableObject(entity: EntityType) -> StorableType {
        let realmUser = StorableUser()
        realmUser.idx = entity.id
        realmUser.name = entity.name
        realmUser.birth = entity.birth
        realmUser.phoneNumber = entity.phoneNumber
        realmUser.photoURL = entity.profileImage
        realmUser.userGender = entity.gender.getGenderValue()
        realmUser.emotion = entity.emotion.getEmotionValue()
        realmUser.userLevel = entity.userLevel
        realmUser.holyLevel = entity.holyLevel
        realmUser.goldkeyTotal = entity.totalGoldkey
        realmUser.classDay = entity.classDayInfo.id
        realmUser.classDayStr = entity.classDayInfo.name
        realmUser.classNight = entity.classNightInfo.id
        realmUser.classNightStr = entity.classNightInfo.name
        realmUser.dayTeachers.append(objectsIn: entity.classDayTeachers.map { TeacherEntityMapper.toStorableObject(entity: $0) })
        realmUser.nightTeachers.append(objectsIn: entity.classNightTeachers.map { TeacherEntityMapper.toStorableObject(entity: $0) })
        realmUser.regDate = entity.registeredDate?.toString() ?? ""
        return realmUser
    }

    static func fromNetworkResponseModel(dto: DTOType) -> EntityType {
        User(id: dto.idx,
             name: dto.name,
             birth: dto.birth,
             phoneNumber: dto.mobile,
             profileImage: dto.photoURL,
             gender: Gender(value: dto.gender),
             emotion: Emotion(value: dto.emotion),
             userLevel: dto.userLevel,
             holyLevel: dto.holyLevel,
             totalGoldkey: dto.totalGoldkey,
             classDayInfo: ClassInfo(id: dto.classDay, name: dto.classDayStr),
             classDayTeachers: dto.dayTeachers.compactMap { TeacherEntityMapper.fromNetworkResponseModel(dto: $0) },
             classNightInfo: ClassInfo(id: dto.classNight, name: dto.classNightStr),
             classNightTeachers: dto.nightTeachers.compactMap { TeacherEntityMapper.fromNetworkResponseModel(dto: $0) },
             registeredDate: dto.regDate.toDate(),
             signedInDate: Date())
    }
}

struct TeacherEntityMapper: Mapper {
    typealias EntityType = Teacher
    typealias DTOType = TeacherResponse
    typealias StorableType = StorableTeacher

    static func fromStorableObject(obj: StorableTeacher) -> Teacher {
        Teacher(id: obj.idx,
                name: obj.userName,
                phoneNumber: obj.userMobile,
                classInfo: ClassInfo(id: obj.classIdx, name: obj.className),
                userLevel: obj.userLevel)
    }

    static func toStorableObject(entity: Teacher) -> StorableTeacher {
        let realmTeacher = StorableTeacher()
        realmTeacher.idx = entity.id
        realmTeacher.userName = entity.name
        realmTeacher.userMobile = entity.phoneNumber
        realmTeacher.className = entity.classInfo.name
        realmTeacher.classIdx = entity.classInfo.id
        realmTeacher.userLevel = entity.userLevel
        return realmTeacher
    }

    static func fromNetworkResponseModel(dto: TeacherResponse) -> Teacher {
        Teacher(id: dto.idx,
                name: dto.userName,
                phoneNumber: dto.userMobile,
                classInfo: ClassInfo(id: dto.classIdx, name: dto.className),
                userLevel: dto.userLevel)
    }
}

extension String {

    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.autoupdatingCurrent

        return formatter.date(from: self)
    }
}

fileprivate extension Gender {
    init(value: Bool) {
        if value {
            self = .male
        } else {
            self = .female
        }
    }

    func getGenderValue() -> Bool {
        if self == .male {
            return true
        } else {
            return false
        }
    }
}

fileprivate extension Emotion {
    init(value: Int) {
        switch value {
        case 1:
            self = .thanks
        case 2:
            self = .angry
        case 3:
            self = .surprised
        case 4:
            self = .worried
        case 5:
            self = .sad
        default:
            self = .thanks
        }
    }

    func getEmotionValue() -> Int {
        switch self {
        case .angry:
            return 2
        case .surprised:
            return 3
        case .worried:
            return 4
        case .sad :
            return 5
        default:
            return 1
        }
    }
}
