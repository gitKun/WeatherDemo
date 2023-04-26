//
/*
* ****************************************************************
*
* 文件名称 : CityListViewController
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
import Combine

class CityListViewController: UIViewController {

// MARK: - 属性

    private let viewModel: CityListViewModelType = CityListViewModel()
    private var cancellable: Set<AnyCancellable> = []

    private var dataSource: [WeatherLifeModel] = []

// MARK: - 生命周期 & override

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        bindViewModel()
        eventListen()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.input.viewWillAppear()
    }

// MARK: - UI element

    private var tableView: UITableView!
}

// MARK: - 事件处理

extension CityListViewController {

    func eventListen() {
        viewModel.input.viewDidLoad()
    }

    private func showDetailVC(with lifeModel: WeatherLifeModel, castModel: WeatherForecastModel) {
        let detailVC = WeatherDetilViewController()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.setupInfo(with: lifeModel, castModel: castModel)
        // TODO: - 转场动画
        navigationController?.present(detailVC, animated: true)
    }
}

// MARK: - 绑定 viewModel

extension CityListViewController {

    func bindViewModel() {
        viewModel.output.allCityWeatherLifeInfo.sink { [weak self] values in
            self?.dataSource = values
            self?.tableView.reloadData()
        }.store(in: &cancellable)

        viewModel.output.cityWeatherDetailInfo.sink { [weak self] (lifeModel, forecastModel) in
            self?.showDetailVC(with: lifeModel, castModel: forecastModel)
        }.store(in: &cancellable)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension CityListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityListCell.reuseID, for: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cityCell = cell as? CityListCell, indexPath.row < dataSource.count {
            cityCell.updateData(with: dataSource[indexPath.row])
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        guard indexPath.row < dataSource.count else { return }
        viewModel.input.showDetailVC(with: dataSource[indexPath.row])
    }
}

// MARK: - 布局UI元素

private extension CityListViewController {

    func configureHierarchy() {
        view.backgroundColor = .black
        navigationItem.title = "天气"

        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tableView)

        tableView.register(CityListCell.self, forCellReuseIdentifier: CityListCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
    }
}
