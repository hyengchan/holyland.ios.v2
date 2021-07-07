//
//  NetworkClient.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/10.
//

import Foundation
import RxSwift
import Alamofire

final class NetworkClient: NetworkClientHelper {
    
    class func signIn(idx: String, password: String) -> Single<Int?> {
        let router = NetworkRouter.signIn(idx: idx, password: password)
        return NetworkClient.request(router)
            .map { (jsonObject) -> Int? in
                jsonObject["idx"] as? Int
            }
    }
    
    // user
    class func userInfo(idx: String) -> Single<NetworkResult<User>> {
        let router = NetworkRouter.user(idx: idx)
        return NetworkClient.request(router)
    }
    
    class func userAttendances(idx: String) -> Single<NetworkResult<[Attendance]>> {
        let router = NetworkRouter.attendances(idx: idx)
        return NetworkClient.request(router)
    }
    
    class func updateUserProfilePhoto(idx: String, imageData: Data?) -> Single<String?> {
        let router = NetworkRouter.updateUserProfilePhoto
        let multipartFormData = { (formData: MultipartFormData) in
            formData.append(Data(idx.utf8), withName: "idx")
            if let date = imageData {
                let currentTimeStamp = Int(Date().timeIntervalSince1970 * 1000000)
                let fileName = "\(idx)_\(currentTimeStamp)"
                
                formData.append(date, withName: "imgFile", fileName: "\(fileName).png", mimeType: "image/png")
            }
        }
        return NetworkClient.upload(router, multipartFormData: multipartFormData)
            .map { (jsonObject) -> String? in
                guard let urlPath = jsonObject["photo"] as? String else {
                    return nil
                }
                return urlPath
            }
    }
    
    class func updateUserEmotion(idx: Int, emotion: Int) -> Single<Bool> {
        let router = NetworkRouter.updateUserEmotion(idx: "\(idx)", emotion: "\(emotion)")
        return NetworkClient.requestSuccess(router,
                                            successRangeCodes: [200, 409])
    }
    
    class func updateUserPassword(idx: String, current: String, new: String) -> Single<Bool> {
        let router = NetworkRouter.updateUserPassword(idx: idx, current: current, new: new)
        return NetworkClient.requestSuccess(router)
    }
    
    class func childs(classIdx: Int) -> Single<NetworkResult<[User]>> {
        let router = NetworkRouter.childs(classIdx: "\(classIdx)")
        return NetworkClient.request(router)
    }
    
    class func allChilds() -> Single<NetworkResult<[User]>> {
        let router = NetworkRouter.allChilds
        return NetworkClient.request(router)
    }
    
    // video
    class func dayVideo(classIdx: Int) -> Single<NetworkResult<Video>> {
        let router = NetworkRouter.videoDay(classIdx: "\(classIdx)")
        return NetworkClient.request(router)
    }
    
    class func dayNight() -> Single<NetworkResult<Video>> {
        let router = NetworkRouter.videoNight
        return NetworkClient.request(router)
    }
    
    class func live(classIdx: Int) -> Single<NetworkResult<Video>> {
        let router = NetworkRouter.videoLive(classIdx: "\(classIdx)")
        return NetworkClient.request(router)
    }
    
    // goldkey
    class func checkObtainableGoldKeys(idx: Int) -> Single<NetworkResult<ObtainableGoldKeyInfo>> {
        let router = NetworkRouter.checkObtainableGoldkeys(idx: "\(idx)")
        return NetworkClient.request(router)
    }
    
    class func requestWeekDayOnGoldkeyCreation(idx: Int) -> Single<NetworkResult<ResponseGoldKeyInfo>> {
        let router = NetworkRouter.requestWeekDayOnGoldkeyCreation(idx: "\(idx)")
        return NetworkClient.request(router)
    }
    
    class func requestWeekDayOffGoldkeyCreation(idx: Int) -> Single<String?> {
        let router = NetworkRouter.requestWeekDayOffGoldkeyCreation(idx: "\(idx)")
        return NetworkClient.request(router)
            .map { (jsonObject) -> String? in
                jsonObject["uname"] as? String
            }
    }
    
    class func requestWeekNightOnGoldkeyCreation(idx: Int) -> Single<NetworkResult<ResponseGoldKeyInfo>> {
        let router = NetworkRouter.requestWeekNightOnGoldkeyCreation(idx: "\(idx)")
        return NetworkClient.request(router)
    }
    
    class func requestWeekNightOffGoldkeyCreation(idx: Int) -> Single<String?> {
        let router = NetworkRouter.requestWeekNightOffGoldkeyCreation(idx: "\(idx)")
        return NetworkClient.request(router)
            .map { (jsonObject) -> String? in
                jsonObject["uname"] as? String
            }
    }
    
    class func requestLiveViewGoldkeyCreation(idx: Int) -> Single<NetworkResult<ResponseGoldKeyInfo>> {
        let router = NetworkRouter.requestLiveViewGoldkeyCreation(idx: "\(idx)")
        return NetworkClient.request(router)
    }
    
    class func requestEarlyLoveGoldkeyCreation(idx: Int) -> Single<NetworkResult<ResponseGoldKeyInfo>> {
        let router = NetworkRouter.requestEarlyLoveGoldkeyCreation(idx: "\(idx)")
        return NetworkClient.request(router)
    }
    
    class func requestFirePillarGoldkeyCreation(idx: Int) -> Single<NetworkResult<ResponseGoldKeyInfo>> {
        let router = NetworkRouter.requestFirePillarGoldkeyCreation(idx: "\(idx)")
        return NetworkClient.request(router)
    }
    
    class func requestMorningTreatGoldkeyCreation(idx: Int) -> Single<NetworkResult<ResponseGoldKeyInfo>> {
        let router = NetworkRouter.requestMorningTreatGoldkeyCreation(idx: "\(idx)")
        return NetworkClient.request(router)
    }
    
    class func requestRouletteSmallGoldkeyCreation(idx: Int) -> Single<NetworkResult<ResponseGoldKeyInfo>> {
        let router = NetworkRouter.requestRouletteSmallGoldkeyCreation(idx: "\(idx)")
        return NetworkClient.request(router)
    }
    
    class func requestRouletteLargeGoldkeyCreation(idx: Int) -> Single<NetworkResult<ResponseGoldKeyInfo>> {
        let router = NetworkRouter.requestRouletteLargeGoldkeyCreation(idx: "\(idx)")
        return NetworkClient.request(router)
    }
    
    class func requestBoxCrashSmallGoldkeyCreation(idx: Int) -> Single<NetworkResult<ResponseGoldKeyInfo>> {
        let router = NetworkRouter.requestBoxCrashSmallGoldkeyCreation(idx: "\(idx)")
        return NetworkClient.request(router)
    }
    
    class func requestBoxCrashLargeGoldkeyCreation(idx: Int) -> Single<NetworkResult<ResponseGoldKeyInfo>> {
        let router = NetworkRouter.requestBoxCrashLargeGoldkeyCreation(idx: "\(idx)")
        return NetworkClient.request(router)
    }
    
    // appbar
    class func dayAppbarImage() -> Single<String?> {
        let router = NetworkRouter.dayAppbarImage
        return NetworkClient.requestString(router)
    }
    class func nightAppbarImage() -> Single<String?> {
        let router = NetworkRouter.nightAppbarImage
        return NetworkClient.requestString(router)
    }
}
