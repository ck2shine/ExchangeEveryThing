//
//  String+Extension.swift
//  CurrencyExTool
//
//  Created by i9400503 on 2020/6/18.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation

extension String {

    func CurrencySeperate() -> (String,String){
        guard self.count == 6 else {
            return ("","")
        }

        let sourceCUR = String(self.prefix(3))
        let toCUR = String(self.suffix(3))
        return (sourceCUR , toCUR)
    }

    func moneyFormat(_ digital : Int? = nil) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        if let digital = digital{
            formatter.maximumFractionDigits = digital
        }
        return formatter.string(from: NSNumber(value: Float(self) ?? 0)) ?? "0"
    }

    func replace(target: String, withString: String) -> String    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
