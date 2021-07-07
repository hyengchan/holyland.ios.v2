//
//  ObservableType+.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/17.
//

import RxSwift
import RxCocoa

public extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
    
    func addSchedulers() -> Self {
        return self
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            // swiftlint:disable force_cast
            .observe(on: MainScheduler.instance) as! Self
            // swiftlint:enable force_cast
    }
}
