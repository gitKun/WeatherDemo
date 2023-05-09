//
/*
* ****************************************************************
*
* 文件名称 : WeatherLifeCell
* 作   者 : Created by 李亚坤
* 创建时间 : 2023/5/4 16:58
* 文件描述 : 
* 注意事项 : 
* 版权声明 : 
* 修改历史 : 2023/5/4 初始版本
*
* ****************************************************************
*/

import UIKit

class WeatherLifeCell: UICollectionViewListCell {

    var lifeModel: WeatherLifeModel?

    override func updateConfiguration(using state: UICellConfigurationState) {
        var newConfiguration = WeatherLifeCellContentConfiguration().updated(for: state)
        newConfiguration.model = lifeModel

        // 设置内容配置以更新自定义内容视图
        contentConfiguration = newConfiguration
    }
}
