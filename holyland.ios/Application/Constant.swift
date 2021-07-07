//
//  Constant.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/08.
//

import Foundation
import UIKit

// swiftlint:disable nesting
struct Constants {
    
    static let appName = "금란홀리랜드"
    static let copyright = "©39degreesC"
    
    struct AppURL {
        private struct Domains {
            static let base = "https://holyland.kumnan.org"
            static let test = "http://13.124.46.53:3000"
        }

        private struct Routes {
            static let api = "/api"
        }

        private static let domain = Domains.test
        private static let route = Routes.api
        
        static let baseURL = domain + route
    }

    struct Topic {
        static let infants = "%EC%98%81%EC%9C%A0%EC%95%84%EB%B6%80".replacingOccurrences(of: "%", with: "")
        static let kinder = "%EC%9C%A0%EC%B9%98%EB%B6%80".replacingOccurrences(of: "%", with: "")
        static let child = "%EC%9C%A0%EB%85%84%EB%B6%80".replacingOccurrences(of: "%", with: "")
        static let elementary = "%EC%B4%88%EB%93%B1%EB%B6%80".replacingOccurrences(of: "%", with: "")
        static let boys = "%EC%86%8C%EB%85%84%EB%B6%80".replacingOccurrences(of: "%", with: "")
    }
    
    struct Design {
        static let basicPadding: CGFloat = 16
        static let heightIphone11: CGFloat = 896
        static let textFieldHeight: CGFloat = 36
        static let textFieldLeftPadding: CGFloat = 8
        static let navigationBarHeight: CGFloat = 64
    }
    
    struct GoldKey {
        static let amountPerLevel = 40 // 금키 40개 기준으로 레벨 +1
    }
    
    struct Video {
        static let attendanceTimeInterval: Double = 30
        static let youtubeFirePillarBibleId = "PLpTypVvyXdaDPxkFTNYYk1NLmt8d2Jqdz"
        static let youtubeMorningTreatBibleId = "PLO0_Udk32NdGrO4-v1MD9le8_vEZpDTZZ"
        static let youtubeEarlyLoveBibleId = "PLpTypVvyXdaA6ql8-vWGi_wcJS49mLtE0"
    }
    
    struct Time {
        static let appbarDay = 6...17
        
        struct Attendance {
            struct Online {
                static let day = 8...16
                static let night = 17...23
            }
           
            struct Offline {
                static let day = 8...16
                static let night = 17...23
            }
        }
    }
}
// swiftlint:enable nesting
