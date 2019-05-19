//
//  CollecttionGameCell.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/19.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import UIKit
import Kingfisher

class CollecttionGameCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK:- 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
//            let iconURL = NSURL(string: group?.icon_url ?? "")!
//            iconImageView.kf.setImage(with: iconURL as! Resource, placeholder: UIImage(named: "home_more_btn"))
            
        }
    }
    
    
   

}
