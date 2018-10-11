//
//  UIColor-Extension.swift
//  DouYu
//
//  Created by Mr wngkai on 2018/9/27.
//  Copyright © 2018 Mr wngkai. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
