//
/*
* ****************************************************************
*
* 文件名称 : CityListCell
* 作   者 : Created by 李亚坤
* 创建时间 : 2023/4/26 09:06
* 文件描述 : 
* 注意事项 : 
* 版权声明 : 
* 修改历史 : 2023/4/26 初始版本
*
* ****************************************************************
*/

import UIKit


final class CityListCell: UITableViewCell {

    static let reuseID: String = "CityListCellID"

// MARK: - 生命周期 & override

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureHierarchy()
        self.selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

// MARK: - UI & lazy elememt

    var bgView: UIView!
    var cityNameLabel: UILabel!
    var temperatureLabel: UILabel!
    var reporttimeLabel: UILabel!
    var weatherLabel: UILabel!
    var moreInfoLabel: UILabel!
}

// MARK: - 事件处理

extension CityListCell {

    private func eventListen() {}

    func updateData(with model: WeatherLifeModel) {
        cityNameLabel.text = model.city
        temperatureLabel.text = model.temperature + "°"
        reporttimeLabel.text = model.reportHourTime
        weatherLabel.text = model.weather
        moreInfoLabel.text = model.moreInfoText
    }
}

// MARK: - 构建 UI 布局层次

private extension CityListCell {

    func configureHierarchy() {
        backgroundColor = .black
        contentView.backgroundColor = .black

        configureBgView()
        configureCityNameLabel()
        configureTemperatureLabel()
        configureReporttimeLabel()
        configureWeatherLabel()
        configureMoreInfoLabel()
    }

    func configureBgView() {
        bgView = UIView(frame: .zero)
        bgView.backgroundColor = .systemTeal
        bgView.roundCorners(.allCorners, radius: 10)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bgView)
        NSLayoutConstraint.activate([
            bgView.heightAnchor.constraint(equalToConstant: 111),
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        ])
    }

    func configureCityNameLabel() {
        cityNameLabel = UILabel(frame: .zero)
        cityNameLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        cityNameLabel.textColor = UIColor.white
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bgView.addSubview(cityNameLabel)
        NSLayoutConstraint.activate([
            cityNameLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: LayoutInfo.leadingSpace),
            cityNameLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: LayoutInfo.topSpace)
        ])
    }

    func configureTemperatureLabel() {
        temperatureLabel = UILabel(frame: .zero)
        temperatureLabel.textColor = .white
        temperatureLabel.font = UIFont.systemFont(ofSize: 48, weight: .semibold)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        bgView.addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: LayoutInfo.topSpace),
            temperatureLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -LayoutInfo.leadingSpace)
            // TODO: - 添加与 nameLable 的约束并设置抗压缩等级
        ])
    }

    func configureReporttimeLabel() {
        reporttimeLabel = UILabel(frame: .zero)
        reporttimeLabel.textColor = .white
        reporttimeLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        reporttimeLabel.translatesAutoresizingMaskIntoConstraints = false
        bgView.addSubview(reporttimeLabel)
        NSLayoutConstraint.activate([
            reporttimeLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: LayoutInfo.leadingSpace),
            reporttimeLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 1)
        ])
    }

    func configureWeatherLabel() {
        weatherLabel = UILabel(frame: .zero)
        weatherLabel.textColor = .white
        weatherLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        bgView.addSubview(weatherLabel)
        NSLayoutConstraint.activate([
            weatherLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: LayoutInfo.leadingSpace),
            weatherLabel.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -LayoutInfo.topSpace)
        ])
    }

    func configureMoreInfoLabel() {
        moreInfoLabel = UILabel(frame: .zero)
        moreInfoLabel.textColor = .white
        moreInfoLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        moreInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        bgView.addSubview(moreInfoLabel)
        NSLayoutConstraint.activate([
            moreInfoLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -LayoutInfo.leadingSpace),
            moreInfoLabel.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -LayoutInfo.topSpace)
        ])
    }
}


fileprivate enum LayoutInfo {
    static let leadingSpace: CGFloat = 16.0
    static let topSpace: CGFloat = 9.0
}
