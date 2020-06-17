//
//  EnvironmentSetting.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation

enum ENVIRONMENT{
    case debug , stage , release
}

class EnvironmentSetting{
    
    //MARK: current environment Type
    static var ENV_TYPE : ENVIRONMENT{
        #if ENV_DEBUG
        return .debug
        #elseif ENV_STAGE
        return .stage
        #elseif ENV_RELEASE
        return .release
        #else
        return .debug
        #endif
    }
    
    static var CUR_HOST_URL : URL {
        
        var SeverHost = ""
        
        switch self.ENV_TYPE {
        //It`s able to change to other environment if it exits
        case .debug:
            SeverHost = "http://api.currencylayer.com"
            break
        case .stage:
            SeverHost = "http://api.currencylayer.com"
            break
        case .release://maybe as a paid user that is able to use https transfer protocol
            SeverHost = "https://api.currencylayer.com"
            break
        }
        
        guard let result = URL(string: SeverHost) else {
            fatalError()
        }
        
        return result
    }
    
    //MARK: list of currency
    static var CUR_LIST : URL {
        
        guard let url = URL(string: "\(CUR_HOST_URL)/list") else {
            fatalError("*** CURL_LIST URL Error***")
        }
        
        return url
    }
    
    //MARK: live currency
    static var CUR_RATE : URL {
        guard let url = URL(string: "\(CUR_HOST_URL)/live") else {
            fatalError("*** CURL_LIST URL Error***")
        }
        
        return url
    }
}
