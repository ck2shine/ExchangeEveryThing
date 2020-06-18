//
//  CurrencySelectVM.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
class CurrencySelectVM : CurrencyRowType , CellIsAbleToPress{
    var pressAction: (() -> ())?

    var curFullName : Box<String>
    var curShortName : Box<String>

    init(model : CurrencyNameModel) {
        self.curFullName = Box(model.curFullName)
        self.curShortName = Box(model.curCode)
    }
}
