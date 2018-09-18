//
//  MainWireframe.swift
//  RxMVVMSample
//
//  Created by Narakky on 2018/09/18.
//  Copyright © 2018年 棤木亮翔. All rights reserved.
//

import UIKit

final class MainWireframe {
    private var doneAlertController: UIAlertController!

    func showDoneAlert() {
        doneAlertController = UIAlertController(title: "Done", message: "Done!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Done!", style: .default, handler: nil)
        doneAlertController.addAction(action)
        UIApplication.shared.keyWindow?.rootViewController?.present(doneAlertController, animated: true, completion: nil)
    }
}
