//
//  NSDate-Extension.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/16.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
