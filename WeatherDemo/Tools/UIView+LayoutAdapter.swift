//
//  UIView+LayoutAdapter.swift
//  WeatherDemo
//
//  Created by liyakun on 2023/5/11.
//

import Foundation
import UIKit


extension NSLayoutConstraint {

    func setMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
        guard let firstItem = firstItem else { return self }

        NSLayoutConstraint.deactivate([self])
        let newConstraint = NSLayoutConstraint(item: firstItem, attribute: firstAttribute, relatedBy: relation, toItem: secondItem, attribute: secondAttribute, multiplier: multiplier, constant: constant)
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        NSLayoutConstraint.activate([newConstraint])

        return newConstraint
    }
}

