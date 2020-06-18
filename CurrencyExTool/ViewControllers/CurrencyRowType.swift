//
//  CurrencyRowType.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
protocol CurrencyRowType {
    
}

protocol CellIsAbleToPress {
    var pressAction : (()->())?{get set}
}
