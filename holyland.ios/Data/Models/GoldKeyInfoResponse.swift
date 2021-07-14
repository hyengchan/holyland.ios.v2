//
//  GoldKeyInfoResponse.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/13.
//

import Foundation

struct GoldKeyInfoResponse: Decodable, DTO {
    let total: Int
    let holyLevel: Int

    enum CodingKeys: String, CodingKey {
        case total
        case holyLevel = "holylevel"
    }
}
