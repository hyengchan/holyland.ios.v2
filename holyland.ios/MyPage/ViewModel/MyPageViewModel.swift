//
//  MyPageViewModel.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/07/02.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import Swinject

class MyPageViewModel: ViewModelType {
    private let container: Container

    private let backSubject = PublishSubject<Void>()

    struct Input { }
    struct Output {
        let backTap: PublishSubject<Void>
    }

    let input: Input
    let output: Output

    init(container: Container) {
        self.container = container

        input = Input()
        output = Output(backTap: backSubject)
    }
}
