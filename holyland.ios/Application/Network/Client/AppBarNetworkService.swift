//
//  AppBarNetworkService.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/07.
//

import Foundation
import RxSwift
import Alamofire

final class AppbarNetworkService: NetworkService {

    class func dayAppbarImage() -> Single<String?> {
        let router = AppBarUIRouter.dayAppbarImage
        return NetworkService.requestString(router)
    }

    class func nightAppbarImage() -> Single<String?> {
        let router = AppBarUIRouter.nightAppbarImage
        return NetworkService.requestString(router)
    }
}
