//
//  RecommendCycleView.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/17.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    
    //MARK:- 定义属性
    var cycleTimer : Timer?
    
    var cycleModels : [CycleModel]? {
        didSet {
            //刷新collectionView
            collectionView.reloadData()
            
            //设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //默认滚动到中间某个位置
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            //添加定时器
            removeCycletimer()
            addCycleTimer()
        }
    }
    
    
    //MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //注册Cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        //设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
      
    }
}

//MARK:- 提供一个快速创建View的类方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}


//MARK:- 遵守UICollectionView的数据源协议
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        
        return cell
        
    }
}

//MARK:- 遵守UICollectionView的代理协议
extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        //计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    //用户开始滚动时移除定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycletimer()
    }
    
    //用户结束滚动时添加定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
    
}

//MARK:- 对定时器的操作方法
extension RecommendCycleView {
    private func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    
    private func removeCycletimer() {
        cycleTimer?.invalidate() // 从运行循环中移除
        cycleTimer = nil
    }
    
    @objc private func scrollToNext() {
        // 获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        // 滚动该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
}
