//
//  GoldKeyMapper.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/14.
//

import Foundation

struct GoldKeyMapper {
    typealias EntityType = GoldKey
    typealias DTOType = GoldKeyResponse

    static func fromNetworkResponseModel(dto: DTOType) -> EntityType {
        GoldKey(weekDay: dto.weekDay,
                weekNight: dto.weekNight,
                liveTab: dto.liveTab,
                liveView: dto.liveView,
                profile: dto.profile,
                earlyLove: dto.earlyLove,
                firePillar: dto.firePillar,
                morningTreat: dto.morningTreat,
                roulette: dto.roulette,
                boxCrash: dto.boxCrash,
                total: dto.total,
                holyLevel: dto.holyLevel)
    }
}

struct GoldKeyInfoMapper {
    typealias EntityType = GoldKeyInfo
    typealias DTOType = GoldKeyInfoResponse

    static func fromNetworkResponseModel(dto: DTOType) -> EntityType {
        GoldKeyInfo(total: dto.total, holyLevel: dto.holyLevel)
    }
}
