//
//  CurrencyMainDependency.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
protocol currencyMainInjectProtocol {
    func fetchCurrencyList(complete completeHandler : @escaping (Result<[CurrencyNameModel],CurrenyFetchError>)->())
    func fetchCurrencyData(complete completeHandler : @escaping (Result<[RateModel],CurrenyFetchError>)->())
}

struct CurrencyMainDependency {
    var currencyMainManager = CurrencyMainManager()
}
