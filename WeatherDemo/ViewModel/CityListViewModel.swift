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

protocol CityListViewModelInputs {

//    func viewDidLoad()
//    func refreshData()
}

protocol CityListViewModelOutputs {
    
}

protocol CityListViewModelType {
    var input: CityListViewModelInputs { get }
    var output: CityListViewModelOutputs { get }
}

final class CityListViewModel: CityListViewModelType, CityListViewModelInputs, CityListViewModelOutputs {
    
    var input: CityListViewModelInputs { self }
    var output: CityListViewModelOutputs { self }
    
    init() {
        
    }
}
