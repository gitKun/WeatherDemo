//
/*
* ****************************************************************
*
* 文件名称 : ViewController
* 作   者 : Created by 李亚坤
* 创建时间 : 2023/4/26 07:59
* 文件描述 : 
* 注意事项 : 
* 版权声明 : 
* 修改历史 : 2023/4/26 初始版本
*
* ****************************************************************
*/

import UIKit
import Moya

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let provider = MoyaProvider<WeathercNetworkService>()
        provider.request(.baseInfo(.beijing)) { result in
            switch result {
            case .success(let response):
                let data = response.data
                do {
                    let model = try JSONDecoder().decode(WeatherResponseModel.self, from: data)
                    print(model.info)
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }


}

