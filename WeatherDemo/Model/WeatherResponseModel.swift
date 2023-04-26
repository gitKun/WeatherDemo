//
/*
* ****************************************************************
*
* 文件名称 : WeatherResponseModel
* 作   者 : Created by 李亚坤
* 创建时间 : 2023/4/26 10:10
* 文件描述 : 
* 注意事项 : 
* 版权声明 : 
* 修改历史 : 2023/4/26 初始版本
*
* ****************************************************************
*/

import Foundation

// MARK: - Wapper
struct WeatherResponseModel: Codable {
    let status, count, info, infocode: String
    let forecasts: [WeatherForecastModel]?
    let lives: [WeatherLifeModel]?
}

// MARK: - WeatherForecastModel
struct WeatherForecastModel: Codable {
    let city, adcode, province, reporttime: String
    let casts: [ForecastCastModel]
}

// MARK: - ForecastCastModel
struct ForecastCastModel: Codable {
    let date, week, dayweather, nightweather: String
    let daytemp, nighttemp, daywind, nightwind: String
    let daypower, nightpower, daytempFloat, nighttempFloat: String

    enum CodingKeys: String, CodingKey {
        case date, week, dayweather, nightweather, daytemp, nighttemp, daywind, nightwind, daypower, nightpower
        case daytempFloat = "daytemp_float"
        case nighttempFloat = "nighttemp_float"
    }
}

// MARK: - WeatherLife
struct WeatherLifeModel: Codable {
    let province, city, adcode, weather: String
    let temperature, winddirection, windpower, humidity: String
    let reporttime, temperatureFloat, humidityFloat: String

    enum CodingKeys: String, CodingKey {
        case province, city, adcode, weather, temperature, winddirection, windpower, humidity, reporttime
        case temperatureFloat = "temperature_float"
        case humidityFloat = "humidity_float"
    }
}

extension WeatherLifeModel {

    var moreInfoText: String {
        "湿度" + humidity + "%  " + winddirection + "风" + windpower + "级"
    }

    var reportHourTime: String {
        let startIdx = reporttime.index(reporttime.startIndex, offsetBy: 11)
        let endIdx = reporttime.index(reporttime.startIndex, offsetBy: 16)
        return String(reporttime[startIdx..<endIdx]) + "发布"
    }
}
