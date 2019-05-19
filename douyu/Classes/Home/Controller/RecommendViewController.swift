//
//  RecommendViewController.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/9.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//
//推荐控制器

import UIKit

private let kPrettyCellID = "kPrettyCellID"
private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {

    //MARK:- 懒加载属性
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    private lazy var collectionView : UICollectionView = {[unowned self] in
        //先创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        //创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        //自动布局
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    private lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setupUI()
        
        //发送网络请求
        loadData()
    }
}

//MARK:- 设置UI界面
extension RecommendViewController {
    private func setupUI() {
        //将UICollectionView添加到控制器的View中
        view.addSubview(collectionView)
        
        //将CycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        
        //将gameView添加到collectionView中
        collectionView.addSubview(gameView)
        
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
    
}

//MARK:- 请求数据
extension RecommendViewController {
    private func loadData() {
        //请求推荐数据
        recommendVM.requestData {
            //展示推荐数据
            self.collectionView.reloadData()
            
            //将数据传给GameView
            self.gameView.groups = self.recommendVM.anchorGroups
        }
        
        //请求轮播数据
        recommendVM.requestCycleData {
           self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

//MARK:- 遵守UICollectionView的数据源协议
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        
        return group.anchors.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
       
        //取出Cell
        if indexPath.section == 1 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
            cell.anchor = anchor
            
            return cell
        } else {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
            
            cell.anchor = anchor
            
            return cell
        }
        
        
    }
    
    //解决collectionview的滚动条被SectionHeader遮挡
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        view.layer.zPosition = 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出setion的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        //取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
