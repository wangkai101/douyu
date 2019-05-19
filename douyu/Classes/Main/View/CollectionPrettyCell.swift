//
//  CollectionPrettyCell.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/15.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: UICollectionViewCell {

    //MARK:- 控件属性
    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    //MARK:- 定义模型属性
    var anchor : AnchorModel? {
        didSet {
            //校验模型是否有值
            guard let anchor = anchor else { return }
            
            //取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            //昵称的显示
            nickNameLabel.text = anchor.nickname
            
            //所在的城市
            cityBtn.setTitle(anchor.anchor_city, for: .normal)
            
            //设置封面图片
            guard let iconURL = NSURL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL as? Resource)
         }
    }
    

}
