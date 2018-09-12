//
//  ViewModelType.swift
//  RxMVVMSample
//
//  Created by Narakky on 2018/09/10.
//  Copyright © 2018年 棤木亮翔. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Dependency
    associatedtype Inputs
    associatedtype Outputs
    init(inputs: Inputs, dependency: Dependency)
    func transform() -> Outputs
}
