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
import Moya

protocol CityListViewModelInputs {
    func viewDidLoad()
    func viewWillAppear()
}

protocol CityListViewModelOutputs {

    var allBaseWeatherInfo: AnyPublisher<[String], Never> { get }
}

protocol CityListViewModelType {
    var input: CityListViewModelInputs { get }
    var output: CityListViewModelOutputs { get }
}

private let request1: PassthroughSubject<Void, Never> = PassthroughSubject()

final class CityListViewModel/*: CityListViewModelType, CityListViewModelInputs, CityListViewModelOutputs*/ {

//    var input: CityListViewModelInputs { self }
//    var output: CityListViewModelOutputs { self }

    var cancellable: Set<AnyCancellable> = []

    init() {

    }

// MARK: - Input

    func viewDidLoad() {
        // 第一次启动 拉取全部数据全部
        
        let ss = request1.flatMap { _ -> AnyPublisher<[WeatherLifeModel], Never> in
            CityAdCode.allCityLifeModelPublisher()
        }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()

        ss.sink { value in
            print(value.count)
        }.store(in: &cancellable)

        request1.send(())
    }

    func viewWillAppear() {
        // 和本地保存的时间戳作比较, 超过三分钟则拉取数据
    }

// MARK: - Output

    
}

fileprivate extension CityAdCode {

    static func allCityLifeModelPublisher() -> AnyPublisher<[WeatherLifeModel], Never> {
        /*
        let beijing = CityAdCode.beijing.lifeModelPublisher
        let shanghai = CityAdCode.shanghai.lifeModelPublisher
        let guangzhou = CityAdCode.guangzhou.lifeModelPublisher
        let shenzhen = CityAdCode.shenzhen.lifeModelPublisher
        let suzhou = CityAdCode.suzhou.lifeModelPublisher
        let shenyang = CityAdCode.shenyang.lifeModelPublisher
        let array = [guangzhou, shenzhen, suzhou, shenyang]
        var zipValue = Publishers.Zip(beijing, shanghai).map { return [$0, $1]}.eraseToAnyPublisher()
        zipValue = array.reduce(zipValue) { partialResult, pub in
            return partialResult.zip(pub) { array, model in
                var reult = array
                reult.append(model)
                return reult
            }.eraseToAnyPublisher()
        }
        */

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
        WeathercNetworkService.baseInfo(self)
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

    /*
   static func generateAllBaseInfoPublisher() -> [AnyPublisher<Result<WeatherResponseModel, Error>, Never>] {
        let result = CityAdCode.allCases.map { code -> AnyPublisher<Result<WeatherResponseModel, Error>, Never> in
            WeathercNetworkService.baseInfo(code)
                .request()
                .map(WeatherResponseModel.self)
                .map { Result<WeatherResponseModel, Error>.success($0) }
                .catch { Just(.failure($0)) }
                .eraseToAnyPublisher()
        }

        return result
    }
     */
}
