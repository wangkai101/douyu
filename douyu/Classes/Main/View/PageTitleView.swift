//
//  PageTitleView.swift
//  douyu
//
//  Created by Mr wngkai on 2019/5/4.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import UIKit

//定义代理协议
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

class PageTitleView: UIView {

    private var currentIndex : Int = 0
    private var titles: [String]
    weak var delegate : PageTitleViewDelegate?
    
//MARK:- 懒加载属性 scrollview
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
//MARK:- 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
//MARK:- 设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView {
    private func setupUI() {
        // 添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //添加title对应的label
        setupTitleLabel()
        
        //设置底线和滑块
        setupBottomMenuAndScrollLine()
    }
    
    private func setupBottomMenuAndScrollLine() {
        //添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //添加scrollLine线
            //先取得第一个Label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
    
    private func setupTitleLabel() {
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //创建UILabel
            let label = UILabel()
            
            //设置UILabel的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            //设置frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //把Label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
        }
    }
}



//MARK:- 监听label的点击
extension PageTitleView {
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer) {
        //获取当前Label
        guard let currentLabel = tapGes.view as? UILabel else {return}
        
        //获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        
        //切换文字颜色
        oldLabel.textColor = UIColor.darkGray
        currentLabel.textColor = UIColor.orange
        
        //保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        //让滚动条位置跟随点击改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.1) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}


//MARK:- 对外暴露的犯法
extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        //取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //颜色的渐变
           //取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.0, kSelectColor.2 - kNormalColor.2)
        
           //变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
           //变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        //记录最新的index
        currentIndex = targetIndex
        
    }
}
