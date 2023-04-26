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

class CityListViewController: UIViewController {

// MARK: - 属性


// MARK: - 生命周期 & override

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        eventListen()
        bindViewModel()
    }

// MARK: - UI element

    private var tableView: UITableView!
}

// MARK: - 事件处理

extension CityListViewController {

    func eventListen() {
    }
}

// MARK: - 绑定 viewModel

extension CityListViewController {

    func bindViewModel() {
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension CityListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityListCell.reuseID, for: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cityCell = cell as? CityListCell {
            cityCell.updateData(with: .init(province: "北京", city: "北京市", adcode: "110000", weather: "晴", temperature: "14", winddirection: "西南", windpower: "4", humidity: "19", reporttime: "2023-04-26 09:08:57", temperatureFloat: "14.0", humidityFloat: "19.0"))
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

    }
}

// MARK: - 布局UI元素

extension CityListViewController {

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
