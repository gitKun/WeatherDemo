//
/*
* ****************************************************************
*
* 文件名称 : WeatherNetworkService
* 作   者 : Created by 李亚坤
* 创建时间 : 2023/4/26 09:13
* 文件描述 : 
* 注意事项 : 
* 版权声明 : 
* 修改历史 : 2023/4/26 初始版本
*
* ****************************************************************
*/

import Foundation
import Moya
import Combine

private let kProvider = MoyaProvider<WeathercNetworkService>()

/// 命名空间
fileprivate enum ServiceInfo {
    static let kWeatherBaseUrl = "https://restapi.amap.com"
    static let kWeatherKey = "39391d17abb338ff15ef42bc90131f66"
}

//struct CityParam: Codable {
//    let adCode: String
//    let name: String
//}

enum CityAdCode: String, CaseIterable {
    case beijing = "110000"
    case shanghai = "310000"
    case guangzhou = "440100"
    case shenzhen = "440300"
    case suzhou = "320500"
    case shenyang = "210100"

    var cityName: String {
        switch self {
        case .beijing:
            return "北京"
        case .shanghai:
            return "上海"
        case .guangzhou:
            return "广州"
        case .shenzhen:
            return "深圳"
        case .suzhou:
            return "苏州"
        case .shenyang:
            return "沈阳"
        }
    }
}

fileprivate extension String {

    var toBaseInfoParam: [String: Any] {
        return ["key": ServiceInfo.kWeatherKey, "city": self, "extensions": "base", "output": "JSON"]
    }

    var toAllInfoParam: [String: Any] {
        return ["key": ServiceInfo.kWeatherKey, "city": self, "extensions": "all", "output": "JSON"]
    }
}

enum WeathercNetworkService {
    /// 返回实况天气
    case baseInfo(String)
    /// 返回预报天气
    case allInfo(String)

    func request() -> AnyPublisher<Response, MoyaError> {
        kProvider.requestPublisher(self)
    }
}

extension WeathercNetworkService: TargetType {

    var headers: [String : String]? {
        var tokenHeader: [String: String] = [:]

        tokenHeader["Accept-Encoding"] = "gzip, deflate, br"
        tokenHeader["Connection"] = "keep-alive"

        return tokenHeader
    }

    var baseURL: URL { URL(string: ServiceInfo.kWeatherBaseUrl)! }

    var path: String { "/v3/weather/weatherInfo" }
    
    var method: Moya.Method { Method.get }
    
    var task: Moya.Task {
        switch self {
        case .baseInfo(let cityAdCode):
            return .requestParameters(parameters: cityAdCode.toBaseInfoParam, encoding: URLEncoding.default)
        case .allInfo(let cityAdCode):
            return .requestParameters(parameters: cityAdCode.toAllInfoParam, encoding: URLEncoding.default)
        }
    }
}
