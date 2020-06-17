//
//  CurrencyDataDependency.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/18.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation

protocol currencyDataModel {    
}

protocol currencyDataInjectProtocol {
    var currencyListDatas : [currencyDataModel]{get set}
}
struct CurrencyDataDependency {
    var currencyDataManager : currencyDataInjectProtocol
}
