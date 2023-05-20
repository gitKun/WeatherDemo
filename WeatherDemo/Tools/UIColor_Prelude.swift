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

    @nonobjc static func random(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: alpha)
    }
}


typealias ColorRGB = (red: CGFloat, green: CGFloat, blue: CGFloat)

extension UIColor {
    
    convenience init(_ rgb: ColorRGB, alpha: CGFloat = 1.0) {
        self.init(red: rgb.red / 255.0, green: rgb.green / 255.0, blue: rgb.blue / 255.0, alpha: alpha)
    }
    
    func getRGB() -> ColorRGB {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        return (red * 255, green * 255, blue * 255)
    }
}
