//
//  NetworkHelper.swift
//  CurrencyExTool
//
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation

class NetworkHelper {

    //MARK: Fetch API from network
    final class func fetchReqeuset(_ url : URL , param : [String:String]? = nil,  complete comepleteHandler : ()->()){

        var request = URLRequest(url: url)

        //set paramaters
        if let param = param{

            var urlComponents = URLComponents()
            var queryItem = [URLQueryItem]()

            param.forEach { (key ,value) in
                let eachQueryItem  = URLQueryItem(name: key, value: value)
                queryItem.append(eachQueryItem)
            }
            urlComponents.queryItems = queryItem
            request.httpBody = urlComponents.query?.data(using: .utf8)
        }
    }
}
