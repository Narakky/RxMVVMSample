//
//  ViewModelType.swift
//  RxMVVMSample
//
//  Created by Narakky on 2018/09/10.
//  Copyright © 2018年 棤木亮翔. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Inputs
    associatedtype Outputs
    func transform(inputs: Inputs) -> Outputs
}
