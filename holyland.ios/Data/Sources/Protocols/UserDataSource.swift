//
//  UserDataSource.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/30.
//

import RxSwift
import Foundation

protocol UserDataSource {
    func siginIn(idx: String, password: String) -> Observable<Int?>
    func userInfo(idx: String) -> Observable<User?>
    func updateEmotion(idx: Int, emotion: Int) -> Observable<Bool>
    func updatePhoto(idx: String, imageData: Data?) -> Observable<String?>
    func updatePassword(idx: Int, current: String, new: String) -> Observable<Bool>
    func attendances(idx: String) -> Observable<[Attendance]>
    func childs(classIdx: Int) ->  Observable<[User]>
    func allChilds() -> Observable<[User]>
}
