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


    enum contentKey : String , CodingKey{
        case success , error , terms , privacy ,currencies
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: contentKey.self)
        success = try container.decode(Bool.self, forKey: .success)
        error = try? container.decode(APIError.self, forKey: .error)
        terms = try container.decode(String.self, forKey: .terms)
        privacy = try container.decode(String.self, forKey: .privacy)

        let curDict = try container.decode([String:String].self, forKey: .currencies)

        var currencyArray = [CurrencyNameModel]()

        curDict.forEach {
            currencyArray.append(CurrencyNameModel(curFullName: $1, curCode: $0))
        }
        currencies = currencyArray
    }

    func encode(to encoder: Encoder) throws {

    }

}


struct CurrencyNameModel : Codable , CurrencyDataModel{
    var curFullName : String
    var curCode : String
}
