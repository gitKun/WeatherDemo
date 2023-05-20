//
//  PageTitleStackScrollStyle.swift
//  WeatherDemo
//
//  Created by liyakun on 2023/5/16.
//

import Foundation
import UIKit

public class PageTitleStackScrollStyle {

    /// titleView
    public var titleViewHeight: CGFloat = 44
    public var titleColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    public var titleSelectedColor: UIColor = .white
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    public var titleSelectedFont: UIFont?
    public var titleViewBackgroundColor: UIColor = .clear
    public var titleViewSelectedColor: UIColor = UIColor.clear
    public var titleMargin: CGFloat = 30
    public var titleInset: CGFloat = 0
    /// 是否固定宽度
    public var isFixedTitleWidth: Bool = false
    /// 固定宽度
    public var titleWidth: CGFloat = 0
    /// titleView 滑动
    public var isTitleViewScrollEnabled: Bool = false
    
    /// title 下划线
    public var isShowBottomLine: Bool = false
    public var bottomLineColor: UIColor = .white
    public var bottomLineHeight: CGFloat = 4
    public var bottomLineWidth: CGFloat = 0
    public var bottomLineRadius: CGFloat = 0

    /// title 缩放
    public var isTitleScaleEnabled: Bool = false
    public var titleMaximumScaleFactor: CGFloat = 1

    /// title 遮罩
    public var isShowCoverView: Bool = false
    public var coverViewBackgroundColor: UIColor = UIColor.black
    public var coverViewAlpha: CGFloat = 0.4
    public var coverMargin: CGFloat = 8
    public var coverViewHeight: CGFloat = 25
    public var coverViewRadius: CGFloat = 12
    
    /// contentView
    public var isContentScrollEnabled: Bool = true
    public var contentViewBackgroundColor = UIColor.white
    public var scrollAnimated = false
    
    public init() {
        
    }
}
