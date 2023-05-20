//
//  CustomLayoutViewController.swift
//  WeatherDemo
//
//  Created by liyakun on 2023/5/10.
//

import UIKit
import Combine


class CustomLayoutViewController: UIViewController {

// MARK: - 属性

    var topImagHeight: CGFloat = 60.0
    private var sections: [Section] = []

    private var cancellable: Set<AnyCancellable> = []

    private var dataSource: UICollectionViewDiffableDataSource<Section, GoodsModel>!

// MARK: - 生命周期 & override

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareData()
        configureHierarchy()
        eventListen()
        bindViewModel()

        applyInitialSnapshots()
    }

// MARK: - UI element

    private var collectionView: UICollectionView!
}


extension CustomLayoutViewController {

    enum Section: Hashable {
        /// banner
        case banner
        /// 精选货物展示为 lsit 模式
        case listGoods
        /// 精选货物展示为 gird 模式
        case gridCoods
    }
}



private extension CustomLayoutViewController {

    func eventListen() {}

    func applyInitialSnapshots() {
        let allSection = sections
        var snapshot = NSDiffableDataSourceSnapshot<Section, GoodsModel>()
        snapshot.appendSections(allSection)
        dataSource.apply(snapshot, animatingDifferences: false)

        var goodsGridSnapshot = NSDiffableDataSourceSectionSnapshot<GoodsModel>()
        goodsGridSnapshot.append(GoodsModel.testModels())
        dataSource.apply(goodsGridSnapshot, to: .gridCoods, animatingDifferences: false)
    }
}

private extension CustomLayoutViewController {

    func bindViewModel() {}
}

private extension CustomLayoutViewController {

    func prepareData() {
        sections = [.gridCoods]
    }

    func configureHierarchy() {
        configureNaiBar()
        configureCollectionView()
    }

    func configureNaiBar() {
        let titleAttr: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 18, weight: .medium)]
        let barAppearance = UINavigationBarAppearance.init()
        barAppearance.titleTextAttributes = titleAttr
        barAppearance.backgroundColor = UIColor.white  // 设置导航栏背景色
        barAppearance.shadowImage = UIImage.init()  // 设置导航栏下边界分割线透明
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance  // 带scroll滑动的页面
        navigationController?.navigationBar.standardAppearance = barAppearance // 常规页面

        navigationItem.title = "自定义Layout"
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)

        configureDataSource()
    }

    func createLayout() -> UICollectionViewLayout {
        let scetionProvider = { [weak self] (sectionIdx: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sections = self?.sections, sections.count > sectionIdx else { return nil }
            let sectionType = sections[sectionIdx]

            switch sectionType {
            case .banner:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .zero
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                // 默认值即为 .none 不滚动
                //section.orthogonalScrollingBehavior = .none
                return section
            case .listGoods:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .zero
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)
                return section
            case .gridCoods:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(120))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(120))
                let leftGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let rightGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: leftGroup)
                return section
            }
        }

        return UICollectionViewCompositionalLayout(sectionProvider: scetionProvider)
    }

    func createGoodsGridCellRegistration() -> UICollectionView.CellRegistration<GoodsGridCell, GoodsModel> {
        return UICollectionView.CellRegistration<GoodsGridCell, GoodsModel> { (cell, indexPath, itemIdentifier) in
            cell.goodsModel = itemIdentifier
        }
    }

    func configureDataSource() {
        let gridGoodsCellConfig = createGoodsGridCellRegistration()
        let allSection = sections
        dataSource = UICollectionViewDiffableDataSource<Section, GoodsModel>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard allSection.count > indexPath.section else { fatalError("Unknown section") }
            let sectionType = allSection[indexPath.section]
            switch sectionType {
            case .gridCoods:
                return collectionView.dequeueConfiguredReusableCell(using: gridGoodsCellConfig, for: indexPath, item: itemIdentifier)
            case .listGoods:
                fatalError()
            case .banner:
                fatalError()
            }
        })
    }
}


final class GoodsGridCell: UICollectionViewCell {

    var goodsModel: GoodsModel? {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    override func updateConfiguration(using state: UICellConfigurationState) {
        var content = GoodsContentConfiguration().updated(for: state)
        content.model = goodsModel
        contentConfiguration = content
    }
}
