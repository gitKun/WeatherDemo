//
//  TestModel.swift
//  WeatherDemo
//
//  Created by liyakun on 2023/5/10.
//

import Foundation
import UIKit


struct BannerModel: Hashable {
    let imageName: String
}

extension BannerModel {
    static func testModels() -> [BannerModel] {
        return [
            .init(imageName: ""),
            .init(imageName: "")
        ]
    }
}

struct GoodsModel: Hashable {
    let placeholderColor: UIColor
    let name: String
    let desc: String
    let price: String

    let imageHWRatio: CGFloat
    let uuid = UUID().uuidString

    static func == (lhs: GoodsModel, rhs: GoodsModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

extension GoodsModel {

    static func testModels() -> [GoodsModel] {
        let models: [GoodsModel] = [
            .init(placeholderColor: .random(), name: "亲自连帽卫衣-女款", desc: "纯棉布面 吸汗透气", price: "￥299", imageHWRatio: 1.0),
            .init(placeholderColor: .random(), name: "天空系列马克杯", desc: "弧线手柄 瓷质透亮易清洗", price: "￥66", imageHWRatio: 1.5),
            .init(placeholderColor: .random(), name: "豪华3D脚垫", desc: "", price: "￥1,498", imageHWRatio: 1.2),
            .init(placeholderColor: .random(), name: "软木杯垫", desc: "隔热防烫 抗水防潮", price: "￥10", imageHWRatio: 1.8)
        ]

        return models

//        let result = Array(0..<12).reduce(models.shuffled(), { partialResult, _ in
//            return partialResult + models.shuffled()
//        })
//        return result
    }
}
