//
//  Emotion.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/11.
//

import UIKit

enum Emotion: Int, CaseIterable {
    case thanks = 1
    case angry = 2
    case surprised = 3
    case worried = 4
    case sad = 5
    
    var description: String {
        switch self {
        case .thanks:
            return "감사해요"
        case .angry:
            return "화가나요"
        case .surprised:
            return "놀랐어요"
        case .worried:
            return "걱정돼요"
        case .sad:
            return "슬퍼요"
        }
    }
    var image: UIImage? {
        switch self {
        case .thanks:
            return UIImage(named: "icMoodThanks")
        case .angry:
            return UIImage(named: "icMoodAngry")
        case .surprised:
            return UIImage(named: "icMoodSurprised")
        case .worried:
            return UIImage(named: "icMoodWorry")
        case .sad:
            return UIImage(named: "icMoodSad")
        }
    }
}
