//
//  BaseGameModel.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/21.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import UIKit

@objcMembers class BaseGameModel: NSObject {
    //MARK:- 定义属性
    var tag_name : String = " "
    var icon_url : String = ""
    
    override init() {
        
    }
    
    //MARK:- 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
