//
//  PageTitleView.swift
//  DouYu
//
//  Created by Mr wngkai on 2018/9/25.
//  Copyright © 2018年 Mr wngkai. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}
private let KScrollLineH : CGFloat = 2

class PageTitleView: UIView {
    // MARK:- 定义属性
    private var currentIndex : Int = 0
    private var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    
    //MARK:- 懒加载属性
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
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
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        
        super.init(frame : frame)
        
//        设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 设置UI界面
extension PageTitleView {
    private func setupUI() {
//        1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
//        2.添加title对应的Label
        setupTitleLabels()
        
//        3.设置底线和滚动的滑块
        setupBottomMenuAndScrollLine()
    }
    
    private func setupTitleLabels() {
        for (index, title) in titles.enumerated() {
//            0.确定label的一些frame的值
            let labelW : CGFloat = frame.width / CGFloat(titles.count)
            let labelH : CGFloat = frame.height - KScrollLineH
            let labelY : CGFloat = 0
//            1.创建UILabel
            let label = UILabel()
//            2.设置Label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
//            3.设置label的frame
           let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
//            4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
//            5.给Label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes: )))
            label.addGestureRecognizer(tapGes)
            
            
            
            
        }
        
        
    }
    
    private func setupBottomMenuAndScrollLine() {
//        1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        scrollView.addSubview(bottomLine)
//        2.添加scrollLine
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor.orange
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - KScrollLineH, width: firstLabel.frame.width, height: KScrollLineH)
        
        
    }
}
//MARK:-监听label的点击
extension PageTitleView {
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer) {
//        1.获取当前Label
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
//        2.获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        
//        3.切换文字的颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
        //4.保存最新Label的下标值
        currentIndex = currentLabel.tag
        
//       5. 滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.2) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
//        6.通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
    }
}

//MARK:- 对外暴漏的方法
extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
//        1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        
    }
}
