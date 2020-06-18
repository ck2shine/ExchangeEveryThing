//
//  APIResponse.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/18.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
protocol APIResponse :Codable {
    var success : Bool{get set}
    var error : APIError?{get set}
}

struct APIError : Codable {
    var code : Int
    var info : String
}
