//
//  AnchorGroup.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/16.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import UIKit

@objcMembers class AnchorGroup: BaseGameModel {
    ///该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
  
    ///组显示的图标
    var icon_name : String = "home_header_normal"
    ///定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    
}
