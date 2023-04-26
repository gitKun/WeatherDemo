//
/*
* ****************************************************************
*
* 文件名称 : ForecastHeaderView
* 作   者 : Created by 李亚坤
* 创建时间 : 2023/4/26 16:50
* 文件描述 : 
* 注意事项 : 
* 版权声明 : 
* 修改历史 : 2023/4/26 初始版本
*
* ****************************************************************
*/

import UIKit

class ForecastHeaderView: UITableViewHeaderFooterView {

    static let reuseID: String = "ForecastHeaderViewID"

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - UI element

    private var titleLabel: UILabel!

// MARK: - 配置 UI

    private func configureHierarchy() {
        backgroundColor = .rgba(r: 38, g: 100, b: 172, a: 0.9)
        contentView.backgroundColor = .rgba(r: 38, g: 100, b: 172, a: 0.9)

        titleLabel = UILabel(frame: .zero)
        titleLabel.textColor = .rgba(r: 255, g: 255, b: 255, a: 0.7)
        titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        titleLabel.text = "3日天气预报"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
