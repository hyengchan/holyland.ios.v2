//
//  ResponseGoldKeyInfo.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/10.
//

import Foundation

struct ResponseGoldKeyInfo: Codable {
    let total: Int
    let holyLevel: Int
    
    enum CodingKeys: String, CodingKey {
        case total
        case holyLevel = "holylevel"
    }
}
