//
//  CurrenctMainManager.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation

enum CurrenyFetchError : Swift.Error {
    case responseError(Int , String)
    case unKnowError(Error)
    var description : String {
        switch self {
        case .responseError(_, let errorInfo):
            return errorInfo
        case .unKnowError(let error):
            return error.localizedDescription
        }

    }
}
class CurrencyMainManager : currencyMainInjectProtocol{

    func fetchCurrencyList(complete completeHandler: @escaping (Result<[CurrencyNameModel],CurrenyFetchError>) -> ()) {
        
        var param = [String:String]()
        param["access_key"] = "0529dadcc5df6fe1ed172d2fd1ff8fcf"
        param["format"] = "1"

        NetworkHelper<DataCurrencyList>.fetch(EnvironmentSetting.CUR_LIST, param: param) {
            switch $0{
            case .success(let model):
                if model.success{
                    completeHandler(.success(model.currencies))
                }else if let error = model.error{
                    completeHandler(.failure(.responseError(error.code, error.info)))
                }
            case .failure(let error):
                completeHandler(.failure(.unKnowError(error)))
            }
        }
    }
    
    
    func fetchCurrencyData(complete completeHandler: @escaping (Result<[RateModel],CurrenyFetchError>)->()) {
        var param = [String:String]()
        param["access_key"] = "0529dadcc5df6fe1ed172d2fd1ff8fcf"
        param["format"] = "1"
        param["currencies"] = "USD,TWD,JPY,AUD,EUR,GBP,PLN"

        NetworkHelper<LiveCurrency>.fetch(EnvironmentSetting.CUR_RATE, param: param) {
            switch $0{
            case .success(let model):
                if model.success{
                    completeHandler(.success(model.quotes))
                }else if let error = model.error{
                    completeHandler(.failure(.responseError(error.code, error.info)))
                }
            case .failure(let error):
                completeHandler(.failure(.unKnowError(error)))
            }
        }
        
    }   
    
}
