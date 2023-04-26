//
/*
* ****************************************************************
*
* 文件名称 : UIView+Corner
* 作   者 : Created by 李亚坤
* 创建时间 : 2023/4/26 11:24
* 文件描述 : 
* 注意事项 : 
* 版权声明 : 
* 修改历史 : 2023/4/26 初始版本
*
* ****************************************************************
*/

import Foundation
import UIKit


extension UIView {

    @available(iOS 11.0, *)
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners.toCACornerMask()
    }
}


extension UIRectCorner {
    func toCACornerMask() ->CACornerMask {
        var ccm: CACornerMask = []
        if self.contains(.topLeft){
            ccm.insert(.layerMinXMinYCorner)
        }
        if self.contains(.topRight){
            ccm.insert(.layerMaxXMinYCorner)
        }
        if self.contains(.bottomLeft){
            ccm.insert(.layerMinXMaxYCorner)
        }
        if self.contains(.bottomRight) {
            ccm.insert(.layerMaxXMaxYCorner)
        }
        if self.contains(.allCorners) {
            return [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        }
        return ccm
    }
}

