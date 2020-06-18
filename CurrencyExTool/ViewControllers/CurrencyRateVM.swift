//
//  CurrencyRateVM.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
class CurrencyRateVM : CurrencyRowType{


    var currenyName : Box<String>
    var amount : Box<String> = Box("")
    var rate : Box<String> = Box("")

    init(model : RateModel , amount : String) {
        self.currenyName = Box(model.convertToCUR)
        self.amount = Box(caculateAmount(rate: model.rate, amount: amount).moneyFormat(5))
        self.rate = Box("1 \(model.convertToCUR) : \(formatTransferRate(rate : model.rate)) \(model.sourceCUR)")
    }
}

extension CurrencyRateVM{
    func caculateAmount(rate : Float , amount : String)->String{

        let amountNum = Float(amount) ?? 0
        let total : Float = rate * amountNum

        return String(format: "%.5f", total)
    }

    func formatTransferRate(rate : Float)->String{
        return String(format: "%.5f", 1/rate)
    }
}
