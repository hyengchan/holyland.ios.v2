//
//  GoldKeyResponse.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/08.
//

import Foundation

struct GoldKeyResponse: Decodable, DTO {
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

    enum CodingKeys: String, CodingKey {
        case weekDay = "week_day"
        case weekNight = "week_night"
        case liveTab = "live_tab"
        case liveView = "live_view"
        case profile
        case earlyLove = "earlylove"
        case firePillar = "firepillar"
        case morningTreat = "morningtreat"
        case roulette
        case boxCrash = "boxcrash"
        case total
        case holyLevel = "holylevel"
    }
}
