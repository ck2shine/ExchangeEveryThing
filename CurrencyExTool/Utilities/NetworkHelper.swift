//
//  NetworkHelper.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/18.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
class NetworkHelper<T:Codable>{
    
    final class func fetch(_ url : URL , param : [String:String] , complete : @escaping (Result<T,Error>)->()){
        NetworkManager.shared.fetchReqeuset(url, param: param) { (data , error) in
            let decoder = JSONDecoder()
            
            if let data = data , let object = try? decoder.decode(T.self, from: data) {
                
                complete(.success(object))
            }else{
                complete(.failure(error))
            }
        }
    }
}
