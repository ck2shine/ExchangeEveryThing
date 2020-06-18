//
//  LiveCurrency.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation

struct LiveCurrency : APIResponse {
    var success: Bool
    var error: APIError?
    var terms: String
    var privacy : String
    var timestamp : Int
    var source : String
    var quotes : [RateModel]

    enum contentKey : String , CodingKey{
        case success , error , terms , privacy ,timestamp,source,quotes
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: contentKey.self)
        success = try container.decode(Bool.self, forKey: .success)
        error = try? container.decode(APIError.self, forKey: .error)
        terms = try container.decode(String.self, forKey: .terms)
        privacy = try container.decode(String.self, forKey: .privacy)
        timestamp = try container.decode(Int.self, forKey: .timestamp)
        source = try container.decode(String.self, forKey: .source)

        let rateDict = try container.decode([String:Float].self, forKey: .quotes)

        var rateArray = [RateModel]()

        rateDict.forEach {
            let curStr = $0.CurrencySeperate()
            rateArray.append(RateModel(sourceCUR: curStr.0, convertToCUR: curStr.1, rate: $1))
        }

        quotes = rateArray

    }

    func encode(to encoder: Encoder) throws {

    }

}

struct RateModel : Codable , CurrencyDataModel{
    var sourceCUR : String
    var convertToCUR : String
    var rate : Float
}


