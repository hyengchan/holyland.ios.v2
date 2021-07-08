//
//  GoldKeyEntity.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/08.
//

import Foundation

struct GoldKey: Entity {
    let weekDay: Bool
    let weekNight: Bool
    let liveTab: Bool
    let liveView: Bool
    let profile: Bool
    let earlyLove: Bool
    let firePillar: Bool
    let morningTreat: Bool
    let roulette: Bool
    let boxCrash: Bool
    let total: Int
    let holyLevel: Int
}

struct GoldKeyInfo: Entity {
    let total: Int
    let holyLevel: Int
}
