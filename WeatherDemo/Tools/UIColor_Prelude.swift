//
/*
* ****************************************************************
*
* 文件名称 : UIColor_Prelude
* 作   者 : Created by 李亚坤
* 创建时间 : 2023/4/26 10:49
* 文件描述 : 
* 注意事项 : 
* 版权声明 : 
* 修改历史 : 2023/4/26 初始版本
*
* ****************************************************************
*/

import Foundation
import UIKit


public extension UIColor {

    @nonobjc static func rgba(r: Float, g: Float, b: Float, a: Float = 1.0) -> UIColor {
        return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue: CGFloat(b / 255.0), alpha: CGFloat(a))
    }
}
