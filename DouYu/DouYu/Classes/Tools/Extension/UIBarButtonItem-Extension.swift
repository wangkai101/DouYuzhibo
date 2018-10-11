//
//  UIBarButtonItem-Extension.swift
//  DouYu
//
//  Created by Mr wngkai on 2018/9/20.
//  Copyright © 2018年 Mr wngkai. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    //使用类方法
   /*
    class func createItem(imageName : String, highImageName : String, point : CGPoint, size : CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        
        btn.frame = CGRect(origin: point, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
 */
    
    //便利构造函数
    convenience init(imageName : String, highImageName : String, point : CGPoint, size : CGSize) {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        
        btn.frame = CGRect(origin: point, size: size)
        
        self.init(customView : btn)
    }
}
