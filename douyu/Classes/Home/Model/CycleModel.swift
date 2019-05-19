//
//  CycleModel.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/17.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    //标题
    var title : String = ""
    //展示的图片信息
    var pic_url : String = ""
    //主播信息对应的字典
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else {return}
            anchor = AnchorModel(dict: room)
        }
    }
    //主播信息对应的模型对象
    var anchor : AnchorModel?
    
    //MARK:- 自定义构造函数
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
