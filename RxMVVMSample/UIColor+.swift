//
//  UIColor+.swift
//  RxMVVMSample
//
//  Created by Narakky on 2018/09/10.
//  Copyright © 2018年 棤木亮翔. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var random: UIColor {
        let r: CGFloat = CGFloat(arc4random_uniform(255)+1) / 255.0
        let g: CGFloat = CGFloat(arc4random_uniform(255)+1) / 255.0
        let b: CGFloat = CGFloat(arc4random_uniform(255)+1) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
