//
//  CurrencyDataManager.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/18.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
class CurrencyDataManager : currencyDataInjectProtocol{
    var selectCurrency: String = ""

    var sendingData: String = ""

    var currencyListDatas: [CurrencyDataModel] = []
}
