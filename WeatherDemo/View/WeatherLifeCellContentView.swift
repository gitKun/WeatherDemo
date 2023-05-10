//
/*
* ****************************************************************
*
* 文件名称 : WeatherLifeCellContentView
* 作   者 : Created by 李亚坤
* 创建时间 : 2023/5/4 17:00
* 文件描述 : 
* 注意事项 : 
* 版权声明 : 
* 修改历史 : 2023/5/4 初始版本
*
* ****************************************************************
*/

import UIKit

class WeatherLifeCellContentView: UIView, UIContentView {

    init(configuration: WeatherLifeCellContentConfiguration) {
        super.init(frame: .zero)

        configureHierarchy()
        apply(configuration: configuration)
    }

    required init?(coder: NSCoder) {
        fatalError(".>_<. WeatherLifeCellContentView!")
    }

    private var currentConfiguration: WeatherLifeCellContentConfiguration!
    var configuration: UIContentConfiguration {
        get {
            currentConfiguration
        }
        set {
            guard let newConfiguration = newValue as? WeatherLifeCellContentConfiguration else { return }
            apply(configuration: newConfiguration)
        }
    }

// MARK: - UI & lazy elememt

    var bgView: UIView!
    var cityNameLabel: UILabel!
    var temperatureLabel: UILabel!
    var reporttimeLabel: UILabel!
    var weatherLabel: UILabel!
    var moreInfoLabel: UILabel!


    /// 负责设置内容视图的值 currentConfiguration 并将所有 currentConfiguration 属性应用于内容视图。
    private func apply(configuration: WeatherLifeCellContentConfiguration) {
        currentConfiguration = configuration

        guard let model = configuration.model else {
            cityNameLabel.text = ""
            temperatureLabel.text = ""
            reporttimeLabel.text = ""
            weatherLabel.text = ""
            moreInfoLabel.text = ""
            return
        }

        cityNameLabel.text = model.city
        temperatureLabel.text = model.temperature + "°"
        reporttimeLabel.text = model.reportHourTime
        weatherLabel.text = model.weather
        moreInfoLabel.text = model.moreInfoText
    }
}


private extension WeatherLifeCellContentView {

    func configureHierarchy() {
        backgroundColor = .black

        configureBgView()
        configureCityNameLabel()
        configureTemperatureLabel()
        configureReporttimeLabel()
        configureWeatherLabel()
        configureMoreInfoLabel()
    }

    func configureBgView() {
        bgView = UIView(frame: .zero)
        bgView.backgroundColor = .rgba(r: 46, g: 110, b: 194)
        bgView.roundCorners(.allCorners, radius: 10)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bgView)
        NSLayoutConstraint.activate([
            bgView.heightAnchor.constraint(equalToConstant: 111),
            bgView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
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
