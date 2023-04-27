//
/*
* ****************************************************************
*
* 文件名称 : ForecastCell
* 作   者 : Created by 李亚坤
* 创建时间 : 2023/4/26 16:34
* 文件描述 : 
* 注意事项 : 
* 版权声明 : 
* 修改历史 : 2023/4/26 初始版本
*
* ****************************************************************
*/

import UIKit

class ForecastCell: UITableViewCell {

    static let reuseID: String = "ForecastCellID"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureHierarchy()
        self.selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

// MARK: - UI element

    private var weekLabel: UILabel!
    private var weatherLabel: UILabel!
    private var windInfoLabel: UILabel!
    private var tempLabel: UILabel!
    private var splitLine: UIView!
}

extension ForecastCell {

    func updateUI(with model: ForecastCastModel) {
        weekLabel.text = model.weekDayByCN
        weatherLabel.text = model.weatherInfo
        tempLabel.text = "\(model.nighttemp)°到\(model.daytemp)°"
        windInfoLabel.text = model.windInfoText
    }
}

private extension ForecastCell {

    func configureHierarchy() {
        backgroundColor = .rgba(r: 38, g: 100, b: 172, a: 0.9)
        contentView.backgroundColor = .rgba(r: 38, g: 100, b: 172, a: 0.9)

        configureSplitLine()
        configureWeekLabbel()
        configureWindInfoLabel()
        configureWeatherLabel()
        configureTempLabel()
    }

    func configureSplitLine() {
        splitLine = UIView(frame: .zero)
        splitLine.backgroundColor = .rgba(r: 255, g: 255, b: 255, a: 0.5)
        splitLine.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(splitLine)
        NSLayoutConstraint.activate([
            splitLine.topAnchor.constraint(equalTo: contentView.topAnchor),
            splitLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            splitLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            splitLine.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }

    func configureWeekLabbel() {
        weekLabel = UILabel(frame: .zero)
        weekLabel.textColor = .white
        weekLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        weekLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(weekLabel)
        NSLayoutConstraint.activate([
            weekLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            weekLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weekLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }

    func configureWeatherLabel() {
        weatherLabel = UILabel(frame: .zero)
        weatherLabel.textColor = .white
        weatherLabel.font = .systemFont(ofSize: 16, weight: .regular)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(weatherLabel)
        NSLayoutConstraint.activate([
            weatherLabel.leadingAnchor.constraint(equalTo: weekLabel.trailingAnchor, constant: 16),
            weatherLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])
    }

    func configureWindInfoLabel() {
        windInfoLabel = UILabel(frame: .zero)
        windInfoLabel.textColor = .white
        windInfoLabel.font = .systemFont(ofSize: 16, weight: .regular)
        windInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(windInfoLabel)
        NSLayoutConstraint.activate([
            windInfoLabel.leadingAnchor.constraint(equalTo: weekLabel.trailingAnchor, constant: 16),
            windInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configureTempLabel() {
        tempLabel = UILabel(frame: .zero)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .right
        tempLabel.font = .systemFont(ofSize: 16, weight: .regular)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
