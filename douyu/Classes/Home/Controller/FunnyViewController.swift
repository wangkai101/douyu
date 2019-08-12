//
//  FunnyViewController.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/24.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import UIKit


private let kNormalCellID = "kNormalCellID"


private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kTopMargin : CGFloat = 20

class FunnyViewController: UIViewController {
    
    private lazy var collectionView : UICollectionView = {[unowned self] in
        //先创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        //创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        //自动布局
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
       
        
        return collectionView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
  
        setupUI()
        view.backgroundColor = UIColor.purple

}
}

//MARK:- 设置UI界面
extension FunnyViewController {
    private func setupUI() {
        view.addSubview(collectionView)
        
        //添加内边距
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
       
    }
}


//MARK:- 遵守UICollectionView的数据源和代理协议
extension FunnyViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 120
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        //给cell设置数据
//                cell.anchor = amuseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    
}
