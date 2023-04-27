//
/*
* ****************************************************************
*
* 文件名称 : ForecastTitleCell
* 作   者 : Created by 李亚坤
* 创建时间 : 2023/4/27 08:17
* 文件描述 : 
* 注意事项 : 
* 版权声明 : 
* 修改历史 : 2023/4/27 初始版本
*
* ****************************************************************
*/

import UIKit

class ForecastTitleCell: UITableViewCell {

    static let reuseID: String = "ForecastTitleCellID"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureHierarchy()
        self.selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

// MARK: - UI element

    private var infoLabel: UILabel!
}

private extension ForecastTitleCell {

    func configureHierarchy() {
        backgroundColor = .rgba(r: 38, g: 100, b: 172, a: 0.9)
        contentView.backgroundColor = .rgba(r: 38, g: 100, b: 172, a: 0.9)

        infoLabel = UILabel(frame: .zero)
        infoLabel.textColor = .rgba(r: 216, g: 229, b: 253)
        infoLabel.text = "3日天气预报"
        infoLabel.textAlignment = .left
        infoLabel.font = .systemFont(ofSize: 13, weight: .regular)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
