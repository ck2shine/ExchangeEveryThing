//
//  CurrencyMainPageVM.swift
//  CurrencyExTool
//
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
class CurrencyMainPageVM{

        
    init(taskManager : currencyMainInjectProtocol) {        
        taskManager.fetchCurrencyList {
            
        }
    }
}
