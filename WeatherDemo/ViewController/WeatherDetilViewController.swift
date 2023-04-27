//
/*
* ****************************************************************
*
* 文件名称 : WeatherDetilViewController
* 作   者 : Created by 李亚坤
* 创建时间 : 2023/4/26 09:05
* 文件描述 : 
* 注意事项 : 
* 版权声明 : 
* 修改历史 : 2023/4/26 初始版本
*
* ****************************************************************
*/

import UIKit


class WeatherDetilViewController: UIViewController {

// MARK: - 属性

    private var lifeModel: WeatherLifeModel!
    private var castModel: WeatherForecastModel!

    private var dataSource: [SectionType] = []

// MARK: - 生命周期 & override

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

// MARK: - UI element

    private var headerView: UIView!
    private var tableView: UITableView!
    private var bottomView: UIView!
    private var listButton: UIButton!
}

// MARK: - 事件处理

extension WeatherDetilViewController {

    func setupInfo(with lifeModel: WeatherLifeModel, castModel: WeatherForecastModel) {
        self.lifeModel = lifeModel
        self.castModel = castModel

        let castList = castModel.casts
        guard !castList.isEmpty else { return }

        var castCellTypes = castList.map { ForecastCellType.forecastInfo($0) }
        castCellTypes.insert(.forecastTitle, at: 0)

        self.dataSource.append(.forecastSection(castCellTypes))
    }

    @objc func listButtonCilcked(_ button: UIButton) {
        self.dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension WeatherDetilViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = dataSource[section]
        switch sectionType {
        case .forecastSection(let list):
            return list.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = dataSource[indexPath.section]
        switch sectionType {
        case .forecastSection(let list):
            let cellType = list[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseID, for: indexPath)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let sectionType = dataSource[indexPath.section]
        switch sectionType {
        case .forecastSection(let list):
            let cellType = list[indexPath.row]
            switch cellType {
            case .forecastTitle:
                break
            case .forecastInfo(let castModel):
                if let castCell = cell as? ForecastCell {
                    castCell.updateUI(with: castModel)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = dataSource[indexPath.section]
        switch sectionType {
        case .forecastSection(let list):
            let cellType = list[indexPath.row]
            switch cellType {
            case .forecastTitle:
                return 34.0
            case .forecastInfo(_):
                return 60.0
            }
        }
    }
}


// MARK: - 布局 UI

private extension WeatherDetilViewController {

    func configureHierarchy() {
        view.backgroundColor = UIColor.rgba(r: 80, g: 138, b: 210)

        configureHeaderView()
        configureBottomView()
        configureListButton()
        configureCollectionView()
    }

    func configureHeaderView() {
        headerView = UIView(frame: .zero)
        headerView.backgroundColor = .clear
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        let heightCons = headerView.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            heightCons,
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        if let info = lifeModel {
            heightCons.constant = 90
            let cityLabel = UILabel(frame: .zero)
            cityLabel.textColor = .white
            cityLabel.font = .systemFont(ofSize: 34, weight: .semibold)
            cityLabel.text = info.city
            cityLabel.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(cityLabel)
            NSLayoutConstraint.activate([
                cityLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 9)
            ])
    
            let infoLabel = UILabel(frame: .zero)
            infoLabel.textColor = .white
            infoLabel.font = .systemFont(ofSize: 20, weight: .semibold)
            infoLabel.text = info.temperature + "° | " + info.weather
            infoLabel.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(infoLabel)
            NSLayoutConstraint.activate([
                infoLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                infoLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 3)
            ])
        }
    }

    func configureBottomView() {
        bottomView = UIView(frame: .zero)
        bottomView.backgroundColor = .rgba(r: 58, g: 124, b: 209)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 80),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func configureListButton() {
        let btnSize: CGFloat = 40
        var btnConfiguration = UIButton.Configuration.plain()
        var imgConfig = UIImage.SymbolConfiguration(paletteColors: [.white])
        imgConfig = imgConfig.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 24.0)))
        btnConfiguration.image = UIImage(systemName: "list.bullet", withConfiguration: imgConfig)
        listButton = UIButton(configuration: btnConfiguration)
        listButton.configurationUpdateHandler = { button in
            button.alpha = button.isHighlighted ? 0.5 : 1
        }
        listButton.addTarget(self, action: #selector(self.listButtonCilcked(_:)), for: .touchUpInside)

        listButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(listButton)
        NSLayoutConstraint.activate([
            listButton.widthAnchor.constraint(equalToConstant: btnSize),
            listButton.heightAnchor.constraint(equalToConstant: btnSize),
            listButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10),
            listButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16)
        ])
    }

    func configureCollectionView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor)
        ])

        tableView.register(ForecastTitleCell.self, forCellReuseIdentifier: ForecastTitleCell.reuseID)
        tableView.register(ForecastCell.self, forCellReuseIdentifier: ForecastCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

fileprivate typealias RangeString = (from: String, to: String)

private enum SectionType {
    case forecastSection([ForecastCellType])
}

private enum ForecastCellType {
    case forecastTitle
    case forecastInfo(ForecastCastModel)

    var reuseID: String {
        switch self {
        case .forecastTitle:
            return ForecastTitleCell.reuseID
        case .forecastInfo(_):
            return ForecastCell.reuseID
        }
    }
}
