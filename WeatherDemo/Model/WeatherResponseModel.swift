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
    let infoType: WeatherInfoType
//    let forecasts: [WeatherForecastModel]?
//    let lives: [WeatherLifeModel]?

    enum CodingKeys: String, CodingKey {
        case status, count, info, infocode
        case forecasts, lives
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decode(String.self, forKey: .status)
        self.count = try container.decode(String.self, forKey: .count)
        self.info = try container.decode(String.self, forKey: .info)
        self.infocode = try container.decode(String.self, forKey: .infocode)
        if let forecasts = try? container.decode([WeatherForecastModel].self, forKey: .forecasts) {
            self.infoType = .forecasts(forecasts)
        } else if let lives = try? container.decode([WeatherLifeModel].self, forKey: .lives) {
            self.infoType = .lives(lives)
        } else {
            fatalError("解析错误 ____#!")
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(status, forKey: .status)
        try container.encode(count, forKey: .count)
        try container.encode(info, forKey: .info)
        try container.encode(infocode, forKey: .infocode)
        switch infoType {
        case .forecasts(let forecasts):
            try container.encode(forecasts, forKey: .forecasts)
        case .lives(let lives):
            try container.encode(lives, forKey: .lives)
        }
    }

    var forecasts: [WeatherForecastModel]? {
        if case .forecasts(let values) = infoType {
            return values
        }
        return nil
    }

    var lives: [WeatherLifeModel]? {
        if case .lives(let values) = infoType {
            return values
        }
        return nil
    }
}




enum WeatherInfoType: Codable {
    case forecasts([WeatherForecastModel])
    case lives([WeatherLifeModel])
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
struct WeatherLifeModel: Codable, Hashable {
    let province, city, adcode, weather: String
    let temperature, winddirection, windpower, humidity: String
    let reporttime, temperatureFloat, humidityFloat: String

    enum CodingKeys: String, CodingKey {
        case province, city, adcode, weather, temperature, winddirection, windpower, humidity, reporttime
        case temperatureFloat = "temperature_float"
        case humidityFloat = "humidity_float"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(adcode)
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

extension ForecastCastModel {
    var windInfoText: String {
        if nightwind == daywind, nightpower == daypower {
            return nightwind + "风" + nightpower + "级"
        }
        if nightwind == daywind {
            return nightwind + "风" + daypower + "到" + nightpower + "级"
        }
        if nightpower == daypower {
            return daywind + "转" + nightwind + "风" + daypower + "级"
        }
        return daywind + "转" + nightwind + "风" + daypower + "到" + nightpower + "级"
    }

    var weekDayByCN: String {
        switch self.week {
        case "1":
            return "周一"
        case "2":
            return "周二"
        case "3":
            return "周三"
        case "4":
            return "周四"
        case "5":
            return "周五"
        case "6":
            return "周六"
        case "7":
            return "周日"
        default:
            return week
        }
    }

    var weatherInfo: String {
        if dayweather == nightweather {
            return dayweather
        }

        return dayweather + "转" + nightweather
    }
}
