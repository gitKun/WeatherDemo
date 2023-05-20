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

    private let viewModel: CityListViewModel = CityListViewModel()
    private var cancellable: Set<AnyCancellable> = []

    private var collectionDataSource: UICollectionViewDiffableDataSource<Section, WeatherLifeModel>!
    private var snapshot: NSDiffableDataSourceSnapshot<Section, WeatherLifeModel>!

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

    private var collectionView: UICollectionView!

    private lazy var coordinator: PushCoordinator = {
        PushCoordinator(viewController: self)
    }()
}

extension CityListViewController {

    enum Section: Hashable {
        case lifeList(String)
    }
}

// MARK: - 事件处理

extension CityListViewController {

    func eventListen() {
        viewModel.input.viewDidLoad()
    }
}

// MARK: - 绑定 viewModel

extension CityListViewController {

    func bindViewModel() {
        viewModel.output.allCityWeatherLifeInfo.sink { [weak self] values in
            var snp = NSDiffableDataSourceSnapshot<Section, WeatherLifeModel>()
            values.forEach { model in
                let section = Section.lifeList(model.adcode)
                snp.appendSections([section])
                snp.appendItems([model], toSection: section)
            }
            self?.snapshot = snp
            self?.collectionDataSource.apply(snp, animatingDifferences: true)
        }.store(in: &cancellable)

        viewModel.output.cityWeatherDetailInfo.sink { [weak self] (lifeModel, forecastModel) in
            self?.coordinator.presentDetailVC(with: lifeModel, forecastModel: forecastModel)
        }.store(in: &cancellable)
    }
}

// MARK: - UICollectionViewDelegate

extension CityListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)

        guard let selectedItem = collectionDataSource.itemIdentifier(for: indexPath) else { return }
        viewModel.input.showDetailVC(with: selectedItem)
    }
}

// MARK: - 布局UI元素

private extension CityListViewController {

    func configureHierarchy() {
        view.backgroundColor = .black
        navigationItem.title = "天气"

        configureCollectionView()
    }

    func configureCollectionView() {

        // 使用 sectionLayout 解决内部布局空隙过大的问题
        let compositionalConfig = UICollectionViewCompositionalLayoutConfiguration()
        compositionalConfig.interSectionSpacing = 0
        let compositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: { section, environment in
            var layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            layoutConfig.backgroundColor = .black // .systemCyan // 打开注释查看界面
            let sectionLayout = NSCollectionLayoutSection.list(using: layoutConfig, layoutEnvironment: environment)
            sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
            return sectionLayout
        }, configuration: compositionalConfig)

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: compositionalLayout)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)

        collectionView.delegate = self
        let lifeCellRegistion = UICollectionView.CellRegistration<WeatherLifeCell, WeatherLifeModel> { (cell, indexPath, itemIdentifier) in
            cell.lifeModel = itemIdentifier
        }

        collectionDataSource = UICollectionViewDiffableDataSource<Section, WeatherLifeModel>(collectionView: collectionView, cellProvider: { (collectionV, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let cell = collectionV.dequeueConfiguredReusableCell(using: lifeCellRegistion, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}
