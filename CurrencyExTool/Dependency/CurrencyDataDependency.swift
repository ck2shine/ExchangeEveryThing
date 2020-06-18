//
//  CurrencyDataDependency.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/18.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation

protocol CurrencyDataModel {
}

protocol currencyDataInjectProtocol {
    var currencyListDatas : [CurrencyDataModel]{get set}
    var sendingData : String{get set}
    var selectCurrency : String{get set}
}
struct CurrencyDataDependency {
    var currencyDataManager = CurrencyDataManager()
}
