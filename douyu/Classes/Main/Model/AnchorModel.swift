//
//  AnchorModel.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/17.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    ///房间号
    var room_id : Int = 0
    
    ///房间图片对应的URLString
    var vertical_src : String = ""
    ///判断手机还是电脑直播 0:电脑 1:手机
    var isVertical : Int = 0
    ///房间名称
    var room_name : String  = ""
    ///主播昵称
    var nickname : String = ""
    ///观看人数
    var online : Int = 0
    ///所在城市
    var anchor_city : String = ""
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
