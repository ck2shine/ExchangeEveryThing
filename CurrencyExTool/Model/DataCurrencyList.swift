//
//  ListDataCurrency.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/18.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
struct DataCurrencyList : APIResponse {
    var success : Bool
    var error: APIError?      
    var terms : String
    var privacy : String
    var currencies : [CurrencyNameModel]
    
    struct CurrencyNameModel : Codable{
        
    }
}


