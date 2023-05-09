//
/*
* ****************************************************************
*
* 文件名称 : WeatherLifeCellContentConfiguration
* 作   者 : Created by 李亚坤
* 创建时间 : 2023/5/4 16:58
* 文件描述 : 
* 注意事项 : 
* 版权声明 : 
* 修改历史 : 2023/5/4 初始版本
*
* ****************************************************************
*/

import Foundation
import UIKit


struct WeatherLifeCellContentConfiguration: UIContentConfiguration, Hashable {

    var model: WeatherLifeModel?
    var bgColor: UIColor?

    func makeContentView() -> UIView & UIContentView {
        return WeatherLifeCellContentView(configuration: self)
    }

    func updated(for state: UIConfigurationState) -> WeatherLifeCellContentConfiguration {
        guard let state = state as? UICellConfigurationState else { return self }

        var updatedConfiguration = self
        if state.isSelected {
            updatedConfiguration.bgColor = .rgba(r: 46, g: 110, b: 194)
        } else {
            updatedConfiguration.bgColor = .rgba(r: 22, g: 140, b: 205)
        }

        return updatedConfiguration
    }
}

