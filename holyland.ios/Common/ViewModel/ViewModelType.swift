//
//  ViewModelType.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/28.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output { get }
}
