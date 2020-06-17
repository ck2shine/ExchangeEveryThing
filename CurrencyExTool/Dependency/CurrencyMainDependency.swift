//
//  CurrencyMainDependency.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
protocol currencyMainInjectProtocol {
    func fetchCurrencyList(complete completeHandler : @escaping ()->())
    func fetchCurrencyData(complete completeHandler : @escaping ()->())
}

struct CurrencyMainDependency {
    var currencyMainManager = CurrencyMainManager()
}
