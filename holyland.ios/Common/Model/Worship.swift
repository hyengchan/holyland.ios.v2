//
//  Worship.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/14.
//

import Foundation
import UIKit

enum Worship: Int {
    case day // 0
    case night // 1
    case live // 2
    
    var description: String {
        switch self {
        case .day:
            return "주일 낮 예배"
        case .night:
            return "주일 저녁 예배"
        case .live:
            return "라이브 예배"
        }
    }
}
