//
//  VideoInformation.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/14.
//

import Foundation

struct VideoInformation {
    let kind: VideoKind
    var viewable: Bool?
}

extension VideoInformation {
    enum VideoKind {
        case vimeo(type: Worship)
        case youtube(type: Youtube)
    }
    
    enum Youtube {
        case firePillarBible
        case morningTreatBible
        case earlyLoveBible
        
        private var baseURLPath: String {
            "https://www.youtube.com/playlist?list="
        }
        
        var url: URL? {
            return URL(string: baseURLPath + self.id)
        }
        
        private var id: String {
            switch self {
            case .firePillarBible:
                return Constants.Video.youtubeFirePillarBibleId
            case .morningTreatBible:
                return Constants.Video.youtubeMorningTreatBibleId
            case .earlyLoveBible:
                return Constants.Video.youtubeEarlyLoveBibleId
            }
        }
        
        var description: String {
            switch self {
            case .earlyLoveBible:
                return "금요 금사빠"
            case .morningTreatBible:
                return "매일 말씀 묵상"
            case .firePillarBible:
                return "불기둥 성경공부"
            }
        }
    }
}
