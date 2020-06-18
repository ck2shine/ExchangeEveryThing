//
//  NetworkHelper.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/18.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
class NetworkHelper<T:Codable>{


    enum NetError : Swift.Error {
        case dataConverError(String)
        case networkError(String)

        var description : String{
            switch self {
            case .dataConverError(let msg):
                return msg
            case .networkError(let msg):
                return msg
            }
        }
    }

    final class func fetch(_ url : URL , param : [String:String] , complete : @escaping (Result<T,NetError>)->()){
        NetworkManager.shared.fetchReqeuset(url, param: param) { (data , error) in
            let decoder = JSONDecoder()

            guard error == nil else {
                return complete(.failure(.networkError(error!.localizedDescription)))
            }

            if let data = data , let object = try? decoder.decode(T.self, from: data) {
                
                complete(.success(object))
            }else{

                complete(.failure(.dataConverError("converting JSON data failed")))
            }
        }
    }
}
