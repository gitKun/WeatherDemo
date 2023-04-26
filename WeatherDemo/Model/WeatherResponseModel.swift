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
    let forecasts: [Forecast]?
    let lives: [Life]?
}

// MARK: - Forecast
struct Forecast: Codable {
    let city, adcode, province, reporttime: String
    let casts: [Cast]
}

// MARK: - Cast
struct Cast: Codable {
    let date, week, dayweather, nightweather: String
    let daytemp, nighttemp, daywind, nightwind: String
    let daypower, nightpower, daytempFloat, nighttempFloat: String

    enum CodingKeys: String, CodingKey {
        case date, week, dayweather, nightweather, daytemp, nighttemp, daywind, nightwind, daypower, nightpower
        case daytempFloat = "daytemp_float"
        case nighttempFloat = "nighttemp_float"
    }
}

// MARK: - Life
struct Life: Codable {
    let province, city, adcode, weather: String
    let temperature, winddirection, windpower, humidity: String
    let reporttime, temperatureFloat, humidityFloat: String

    enum CodingKeys: String, CodingKey {
        case province, city, adcode, weather, temperature, winddirection, windpower, humidity, reporttime
        case temperatureFloat = "temperature_float"
        case humidityFloat = "humidity_float"
    }
}
