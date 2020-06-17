//
//  CurrenctMainManager.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
class CurrencyMainManager : currencyMainInjectProtocol{
      
    
    func fetchCurrencyList(complete completeHandler: @escaping () -> ()) {
        
        var param = [String:String]()
        param["access_key"] = "0529dadcc5df6fe1ed172d2fd1ff8fcf"
        param["format"] = "1"
        NetworkManager.shared.fetchReqeuset(EnvironmentSetting.CUR_LIST, param: param) {data ,error in 
            
        }
    }
    
    
    func fetchCurrencyData(complete completeHandler: @escaping () -> ()) {
        
        
    }   
    
}
