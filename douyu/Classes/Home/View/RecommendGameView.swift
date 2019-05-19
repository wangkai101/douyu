//
//  RecommendGameView.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/19.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"


class RecommendGameView: UIView {
    
    //MARK:- 定义数据的属性
    var groups : [AnchorGroup]? {
        didSet {
            //移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            //添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            
            //刷新表格
            collectionView.reloadData()
        }
    }
    

    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //注册Cell
        collectionView.register(UINib(nibName: "CollecttionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        //添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
}

//MARK:- 提供快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

//MARK:- 遵守UICollectionView的数据源协议
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
     
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollecttionGameCell
        
        cell.group = groups![indexPath.item]
        
        
        return cell
        
    }
    
    
}

