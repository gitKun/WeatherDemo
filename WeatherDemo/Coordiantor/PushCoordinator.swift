//
//  PushCoordinator.swift
//  WeatherDemo
//
//  Created by liyakun on 2023/5/10.
//

import Foundation
import UIKit


final class PushCoordinator {

    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

// MARK: - getter

    private var navigationController: UINavigationController? {
        guard let currentVC = viewController else { return nil }
        if let navVC = currentVC as? UINavigationController { return navVC }
        return currentVC.navigationController
    }
}

// MARK: - 跳转逻辑

extension PushCoordinator {

    func presentDetailVC(with lifeModel: WeatherLifeModel, forecastModel: WeatherForecastModel) {
        let detailVC = WeatherDetilViewController()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.setupInfo(with: lifeModel, castModel: forecastModel)
        // TODO: - 转场动画
        navigationController?.present(detailVC, animated: true)
    }
}
