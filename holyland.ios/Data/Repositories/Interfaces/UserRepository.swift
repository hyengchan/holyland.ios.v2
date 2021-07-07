//
//  LocalDataSource.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/15.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserRepository {
    var user: BehaviorRelay<User?> { get }
    
    func siginIn(idx: String, password: String) -> Observable<Int?>
    func userInfo(idx: Int) -> Observable<User?>
    func deleteUser(_ user: User) -> Observable<Bool>
    
    func updatePassword(current: String, new: String) -> Observable<Bool>
    func updatePhoto(imageData: Data?) -> Observable<String?>   /// photoURLPath, updatedGoldkeyInfo
    func updateEmotion(_ emotion: Int) -> Observable<Bool>
    
    func attendances(idx: Int) -> Observable<[Attendance]>
    
    func initAll()
}
