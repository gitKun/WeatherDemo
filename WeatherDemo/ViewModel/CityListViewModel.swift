//
/*
* ****************************************************************
*
* 文件名称 : CityListViewModel
* 作   者 : Created by 李亚坤
* 创建时间 : 2023/4/26 09:09
* 文件描述 : 
* 注意事项 : 
* 版权声明 : 
* 修改历史 : 2023/4/26 初始版本
*
* ****************************************************************
*/

import Foundation
import Combine


protocol CityListViewModelInputs {
    func viewDidLoad()
    func viewWillAppear()

    func showDetailVC(with model: WeatherLifeModel)
}

protocol CityListViewModelOutputs {

    var allCityWeatherLifeInfo: AnyPublisher<[WeatherLifeModel], Never> { get }
    var cityWeatherDetailInfo: AnyPublisher<(WeatherLifeModel, WeatherForecastModel), Never> { get }
}

protocol CityListViewModelType {
    var input: CityListViewModelInputs { get }
    var output: CityListViewModelOutputs { get }
}

final class CityListViewModel: CityListViewModelType, CityListViewModelInputs, CityListViewModelOutputs {

    private let queryDataSubject: ObservableObjectPublisher = ObservableObjectPublisher()
    private let queryDetailInfoSubject: PassthroughSubject<WeatherLifeModel, Never> = PassthroughSubject()
    private var lastQueryTime: TimeInterval = 0

    init() {}

// MARK: - ViewModelType

    var input: CityListViewModelInputs { self }
    var output: CityListViewModelOutputs { self }

// MARK: - Input

    func viewDidLoad() {
        // 第一次启动 拉取全部数据全部, 记录拉取数据的时间点
        queryDataSubject.send()
        lastQueryTime = Date().timeIntervalSince1970
    }

    func viewWillAppear() {
        let currentTime = Date().timeIntervalSince1970

        // 数据超过3分钟,再次请求
        if lastQueryTime + 1800 < currentTime {
            lastQueryTime = currentTime
            queryDataSubject.send()
        }
    }

    func showDetailVC(with model: WeatherLifeModel) {
        queryDetailInfoSubject.send(model)
    }

// MARK: - Output

    private lazy var allLifePulisher: AnyPublisher<[WeatherLifeModel], Never> = {
        let subject = self.queryDataSubject
            .flatMap { _ -> AnyPublisher<[WeatherLifeModel], Never> in
                CityAdCode.allCityLifeModelPublisher()
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        return subject
    }()

    var allCityWeatherLifeInfo: AnyPublisher<[WeatherLifeModel], Never> {
        return self.allLifePulisher
    }

    var cityWeatherDetailInfo: AnyPublisher<(WeatherLifeModel, WeatherForecastModel), Never> {
        self.createQueryDetailPublisher().receive(on: RunLoop.main).eraseToAnyPublisher()
    }
}


private extension CityListViewModel {

    func createQueryDetailPublisher() -> AnyPublisher<(WeatherLifeModel, WeatherForecastModel), Never> {
        queryDetailInfoSubject.flatMap { lifeModel -> AnyPublisher<(WeatherLifeModel, WeatherForecastModel), Never> in
            WeathercNetworkService.allInfo(lifeModel.adcode)
                .request()
                .map(WeatherResponseModel.self)
                .map { Result<WeatherResponseModel, Error>.success($0) }
                .catch { Just(.failure($0)) }
                .map { response -> WeatherForecastModel? in
                    switch response {
                    case .success(let model):
                        return model.forecasts?.first
                    case .failure(_):
                        return nil
                    }
                }
                .compactMap { $0 }
                .map { forecastModel -> (WeatherLifeModel, WeatherForecastModel) in
                    return (lifeModel, forecastModel)
                }
                .eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    
    }
}



fileprivate extension CityAdCode {

    static func allCityLifeModelPublisher() -> AnyPublisher<[WeatherLifeModel], Never> {
        let allPulisher = CityAdCode.allCases.map { $0.lifeModelPublisher }
        var zipValue = Publishers.Zip(allPulisher[0], allPulisher[1]).map { return [$0, $1]}.eraseToAnyPublisher()
        zipValue = allPulisher.dropFirst(2).reduce(zipValue) { partialResult, pub in
            return partialResult.zip(pub) { array, model in
                var reult = array
                reult.append(model)
                return reult
            }.eraseToAnyPublisher()
        }

        return zipValue
    }

    private var lifeModelPublisher: AnyPublisher<WeatherLifeModel, Never> {
        WeathercNetworkService.baseInfo(self.rawValue)
            .request()
            .map(WeatherResponseModel.self)
            .map { Result<WeatherResponseModel, Error>.success($0) }
            .catch { Just(.failure($0)) }
            .map { response -> WeatherLifeModel? in
                switch response {
                case .success(let model):
                    return model.lives?.first
                case .failure(_):
                    return nil
                }
            }
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
}
