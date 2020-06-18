//
//  LocalStoreCurrency.swift
//  CurrencyExTool
//
//  Created by i9400503 on 2020/6/18.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
struct LocalStoreCurrency : Codable {
    var rateArray : [RateModel]
    var listArray : [CurrencyNameModel]
}
