//
//  ViewModel.swift
//  RxMVVMSample
//
//  Created by Narakky on 2018/09/10.
//  Copyright © 2018年 棤木亮翔. All rights reserved.
//

import RxSwift
import RxCocoa

private typealias Dependency = (repository: Any, wireframe: Any)

protocol ViewModelInputs {

}

protocol ViewModelOutputs {

}

private protocol ViewModelProtocol {
    var inputs: ViewModelInputs { get }
    var outputs: ViewModelOutputs { get }
}

class ViewModel: ViewModelProtocol {
    let inputs: ViewModelInputs
    let outputs: ViewModelOutputs

    init(inputs: ViewModelInputs, outputs: ViewModelOutputs) {
        self.inputs = inputs
        self.outputs = outputs
    }
}
