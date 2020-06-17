//
//  NetworkHelper.swift
//  CurrencyExTool
//
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    //MARK: Fetch API from network
    final func fetchReqeuset(_ url : URL , param : [String:String]? = nil,  complete comepleteHandler : @escaping ( Data? , Error?)->()){
        
        var urlStr = url.absoluteString        
        
        if let param = param{
            urlStr.append("?")
            param.forEach { (key ,value) in
                urlStr.append("\(key)=\(value)&")
            }
        }
        
        let request = URLRequest(url: URL(string: urlStr)!)
           
        let task =  URLSession.shared.dataTask(with: request) { (data, response, error) in
          comepleteHandler(data,error)
        }
        
        task.resume()
    }
}
