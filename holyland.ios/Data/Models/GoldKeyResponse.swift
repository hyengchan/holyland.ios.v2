//
//  GoldKeyResponse.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/08.
//

import Foundation

struct GoldKeyResponse: Decodable, DTO {
    let weekDay: Bool
    let liveView: Bool
    let holyLevel: Int
    let liveTab: Bool
    let total: Int
    let weekNight: Bool
    let roulette: Bool
    let boxCrash: Bool
    let profile: Bool
    let earlyLove: Bool
    let firePillar: Bool
    let morningTreat: Bool

    enum CodingKeys: String, CodingKey {
        case weekDay = "week_day"
        case liveView = "live_view"
        case holyLevel = "holylevel"
        case liveTab = "live_tab"
        case total
        case weekNight = "week_night"
        case roulette
        case boxCrash = "boxcrash"
        case profile
        case earlyLove = "earlylove"
        case firePillar = "firepillar"
        case morningTreat = "morningtreat"
    }
}
