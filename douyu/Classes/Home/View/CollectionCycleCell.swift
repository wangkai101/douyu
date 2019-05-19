//
//  CollectionCycleCell.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/18.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {

    //MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = NSURL(string: cycleModel?.pic_url ?? "")!
//            iconImageView.kf.setImage(with: iconURL as! Resource, placeholder: UIImage(named: "Img_default"))
            
        }
    }
    

}
