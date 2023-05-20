//
//  PageTitleStackScrollView.swift
//  WeatherDemo
//
//  Created by liyakun on 2023/5/16.
//

import UIKit


public typealias TitleClickHandler = (PageTitleStackScrollView, Int) -> Void

public class PageTitleStackScrollView: UIView {

// MARK: - 属性

    fileprivate static let titleLabelTag: Int = 2023

    /// 点击标题时调用
    public var clickHandler: TitleClickHandler?
    private (set) public var currentIndex: Int = 0 {
        didSet {
            // delegate?.updateCurrentIndex(currentIndex)
        }
    }

    private (set) public lazy var titleLabels: [UILabel] = [UILabel]()
    private (set) public var style: PageTitleStackScrollStyle = PageTitleStackScrollStyle()
    private (set) public var titles: [String] = [String]()

    private lazy var normalRGB: ColorRGB = style.titleColor.getRGB()
    private lazy var selectRGB: ColorRGB = style.titleSelectedColor.getRGB()
    private lazy var deltaRGB: ColorRGB = {
        let deltaR = selectRGB.red - normalRGB.red
        let deltaG = selectRGB.green - normalRGB.green
        let deltaB = selectRGB.blue - normalRGB.blue
        return (deltaR, deltaG, deltaB)
    }()

// MARK: - 生命周期 & override

    public init(frame: CGRect, style: PageTitleStackScrollStyle, titles: [String], currentIndex: Int = 0) {
        super.init(frame: frame)
        configureHierarchy()
    }

    /// 不支持 xib, 请勿使用
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = CGRect(origin: CGPoint.zero, size: frame.size)
        guard titles.count > 0 else { return }
        layoutLabels()
        layoutBottomLine()
        layoutCoverView()
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateColors()
    }

// MARK: - UI element

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = false
        return scrollView
    }()

    /// titleLabel 的父试图
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private lazy var bottomLine: UIView = { UIView() }()
    private (set) public lazy var coverView: UIView = { UIView() }()
}

// MARK: - 对外方法

extension PageTitleStackScrollView {

    /// 通过代码实现点了某个位置的 titleView
    ///
    /// - Parameter index: 需要点击的 titleView 的索引
    public func selectedTitle(at index: Int, animated: Bool = true) {
        if index > titles.count || index < 0 {
            print("PageTitleStackScrollView -- selectedTitle: 数组越界了, index 的值超出有效范围")
            return
        }

        clickHandler?(self, index)

        if index == currentIndex {
           // delegate?.eventHandler?.titleViewDidSelectSameTitle()
            return
        }

        let sourceLabel = titleLabels[currentIndex]
        let targetLabel = titleLabels[index]

        sourceLabel.textColor = style.titleColor
        sourceLabel.font = style.titleFont

        targetLabel.textColor = style.titleSelectedColor

        if let font = style.titleSelectedFont {
            targetLabel.font = font
        }

        // delegate?.eventHandler?.contentViewDidDisappear()

        currentIndex = index

        // delegate?.titleView(self, didSelectAt: currentIndex)
        adjustLabelPosition(targetLabel, animated: animated)

        if style.isTitleScaleEnabled {
            UIView.animate(withDuration: 0.25, animations: {
                sourceLabel.transform = CGAffineTransform.identity
                targetLabel.transform = CGAffineTransform(scaleX: self.style.titleMaximumScaleFactor, y: self.style.titleMaximumScaleFactor)
            })
        }

        if style.isShowBottomLine {
            let titleInset = style.isTitleViewScrollEnabled ? style.titleInset : 0
            UIView.animate(withDuration: 0.25, animations: {
                self.bottomLine.frame.size.width = self.style.bottomLineWidth > 0 ?
                    self.style.bottomLineWidth : targetLabel.frame.width - titleInset
                self.bottomLine.center.x = targetLabel.center.x
            })
        }

        if style.isShowCoverView {
            UIView.animate(withDuration: 0.25, animations: {
                self.coverView.frame.size.width = self.style.isTitleViewScrollEnabled ?
                    (targetLabel.frame.width + self.style.coverMargin * 2) : targetLabel.frame.width
                self.coverView.center.x = targetLabel.center.x
            })
        }

        sourceLabel.backgroundColor = UIColor.clear
        targetLabel.backgroundColor = style.titleViewSelectedColor
    }

    public func updateTitle(_ title: String, at index: Int) {
        if index > titles.count || index < 0 {
            print("PageTitleStackScrollView -- updateTitle(_:at:): 数组越界了, index 的值超出有效范围")
            return
        }

        let lab = titleLabels[index]
        titles[index] = title
        lab.text = title

        setNeedsLayout()
    }
}

// MARK： - 内部事件处理

private extension PageTitleStackScrollView {

    func updateColors() {
        normalRGB = style.titleColor.getRGB()
        selectRGB = style.titleSelectedColor.getRGB()
        let deltaR = selectRGB.red - normalRGB.red
        let deltaG = selectRGB.green - normalRGB.green
        let deltaB = selectRGB.blue - normalRGB.blue
        deltaRGB = (deltaR, deltaG, deltaB)
    }
}


// MARK: - 构建 UI
extension PageTitleStackScrollView {

    func configure(titles: [String], style: PageTitleStackScrollStyle = PageTitleStackScrollStyle(), currentIndex: Int? = nil) {

        self.titles = titles

        self.style = style
        updateColors()

        if let currentIndex = currentIndex {
            self.currentIndex = currentIndex
        }

        configureSubViews()
    }

//    public func setLabelAndLine() {
//        for (idx, title) in titles.enumerated() {
//            configureLabel(titleLabels[idx], idx, title)
//        }
//
//        guard style.isShowBottomLine else {
//            bottomLine.removeFromSuperview()
//            return
//        }
//
//        updateColors()
//        bottomLine.backgroundColor = style.bottomLineColor
//        bottomLine.layer.cornerRadius = style.bottomLineRadius
//        scrollView.backgroundColor = style.titleViewBackgroundColor
//    }

    private func configureSubViews() {
        scrollView.backgroundColor = style.titleViewBackgroundColor
        configureLabelsIfNeed()
        updateBottomLine()
        updateCoverView()
    }

    /// 更新或者创建 label
    private func configureLabelsIfNeed() {
        if titles.count == titleLabels.count {
            for (idx, title) in titles.enumerated() {
                configureLabel(titleLabels[idx], idx, title)
            }
        } else {
            if !titleLabels.isEmpty {
                titleLabels.forEach { self.contentStackView.removeArrangedSubview($0) }
                titleLabels = []
            }

            for (i, title) in titles.enumerated() {
                let label = UILabel()
                let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapedTitleLabel(_:)))
                label.addGestureRecognizer(tapGes)
                label.isUserInteractionEnabled = true
                configureLabel(label, i, title)
                contentStackView.addArrangedSubview(label)
                titleLabels.append(label)
            }
        }
    }

    private func configureLabel(_ label: UILabel, _ idx: Int, _ title: String) {
        label.tag = idx + PageTitleStackScrollView.titleLabelTag
        label.text = title
        label.textAlignment = .center
        label.textColor = idx == currentIndex ? style.titleSelectedColor : style.titleColor
        label.backgroundColor = idx == currentIndex ? style.titleViewSelectedColor : UIColor.clear
        let font = idx == currentIndex ? style.titleSelectedFont : style.titleFont
        label.font = font ?? style.titleFont
    }

    private func updateBottomLine() {
        guard style.isShowBottomLine else {
            bottomLine.removeFromSuperview()
            return
        }

        bottomLine.backgroundColor = style.bottomLineColor
        bottomLine.layer.cornerRadius = style.bottomLineRadius
        scrollView.addSubview(bottomLine)
    }

    private func updateCoverView() {
        guard style.isShowCoverView else {
            coverView.removeFromSuperview()
            return
        }

        coverView.backgroundColor = style.coverViewBackgroundColor
        coverView.alpha = style.coverViewAlpha
        coverView.layer.cornerRadius = style.coverViewRadius
        coverView.layer.masksToBounds = true
        scrollView.insertSubview(coverView, at: 0)
    }
}

// MARK: - Layout

extension PageTitleStackScrollView {

    private func layoutLabels() {
        var width: CGFloat = 0
        let count = titleLabels.count
        for titleLabel in titleLabels {
            // 不可滚动
            if !style.isTitleViewScrollEnabled {
                width = frame.width / CGFloat(count)
                if style.isFixedTitleWidth {
                    width = style.titleWidth
                }

                NSLayoutConstraint.activate([
                    titleLabel.widthAnchor.constraint(equalToConstant: width)
                ])
            }
            titleLabel.transform = .identity
        }

        if let font = style.titleSelectedFont {
            let tempLabel = titleLabels[currentIndex]
            tempLabel.font = font
        }

        if style.isTitleScaleEnabled {
            titleLabels[currentIndex].transform = CGAffineTransform(scaleX: style.titleMaximumScaleFactor, y: style.titleMaximumScaleFactor)
        }

        let tempLabel = titleLabels[currentIndex]
        adjustLabelPosition(tempLabel, animated: false)
        fixUI(tempLabel)
    }

    private func layoutCoverView() {
        guard currentIndex < titleLabels.count else { return }
        let label = titleLabels[currentIndex]
        var width = label.frame.width
        let height = style.coverViewHeight
        if style.isTitleViewScrollEnabled {
            width += 2 * style.coverMargin
        }
        coverView.frame.size = CGSize(width: width, height: height)
        coverView.center = label.center
    }

    private func layoutBottomLine() {
        guard currentIndex < titleLabels.count else { return }
        let label = titleLabels[currentIndex]

        let titleInset = style.isTitleViewScrollEnabled ? style.titleInset : 0
        bottomLine.frame.size.width = style.bottomLineWidth > 0 ? style.bottomLineWidth : label.frame.width - titleInset
        bottomLine.frame.size.height = style.bottomLineHeight
        bottomLine.center.x = label.center.x
        bottomLine.frame.origin.y = frame.height - bottomLine.frame.height
    }

    private func fixUI(_ targetLabel: UILabel) {

        UIView.animate(withDuration: 0.05) {
            targetLabel.textColor = self.style.titleSelectedColor

            if self.style.isTitleScaleEnabled {
                targetLabel.transform = CGAffineTransform(scaleX: self.style.titleMaximumScaleFactor, y: self.style.titleMaximumScaleFactor)
            }

            if self.style.isShowBottomLine {
                if self.style.bottomLineWidth <= 0 {
                    let titleInset = self.style.isTitleViewScrollEnabled ? self.style.titleInset : 0
                    self.bottomLine.frame.size.width = targetLabel.frame.width - titleInset
                }
                self.bottomLine.center.x = targetLabel.center.x
            }

            if self.style.isShowCoverView {
                self.coverView.frame.size.width = self.style.isTitleViewScrollEnabled ?
                    (targetLabel.frame.width + 2 * self.style.coverMargin) :
                    targetLabel.frame.width
                self.coverView.center.x = targetLabel.center.x
            }
        }
    }
}

extension PageTitleStackScrollView {

    @objc private func tapedTitleLabel(_ tapGes: UITapGestureRecognizer) {
        guard let tapTag = tapGes.view?.tag else { return }
        let index = tapTag - PageTitleStackScrollView.titleLabelTag
        guard index > 0 else { return }

        selectedTitle(at: index)
    }

    /// 滚动到中心位置
    private func adjustLabelPosition(_ targetLabel: UILabel, animated: Bool) {
        guard style.isTitleViewScrollEnabled,
            scrollView.contentSize.width > scrollView.frame.width
            else { return }

        var offsetX = targetLabel.center.x - frame.width * 0.5

        if offsetX < 0 {
            offsetX = 0
        }

        if offsetX > scrollView.contentSize.width - scrollView.frame.width {
            offsetX = scrollView.contentSize.width - scrollView.frame.width
        }

        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: animated)
    }
}

// MARK: - 布局 UI

private extension PageTitleStackScrollView {

    func configureHierarchy() {
        // 添加哨兵 view
        let sentinelView = UIView()
        sentinelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sentinelView.widthAnchor.constraint(equalToConstant: 0)
        ])
        contentStackView.addArrangedSubview(sentinelView)

        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // scrollView
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            // stackView
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])

        func configureBottomLine() {
            
        }
    }

}
