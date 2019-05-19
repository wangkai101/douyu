//
//  UIColor-Extension.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/4.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
