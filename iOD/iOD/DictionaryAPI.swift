//
//  DictionaryAPI.swift
//  iOD
//
//  Created by Rafael Almeida on 21/01/17.
//  Copyright © 2017 Rafael Almeida. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DictionaryAPI {
    let BASE_URL = "http://www.dicionario-aberto.net/search-json/"
    
    func fetchLiteralExpression (keyword: String, completionHandler: @escaping (Array<Dictionary<String, String>>, Error?) -> ()) {
        let escapedQuery = keyword.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        makeRequest(keyword: keyword, url: "\(BASE_URL)\(escapedQuery!)", completionHandler: completionHandler)
    }
    
    func makeRequest(keyword: String, url: String, completionHandler: @escaping (Array<Dictionary<String, String>>, Error?) -> ()) {
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                completionHandler(self.parseJSON(json: json), nil)
            case .failure(let error):
                completionHandler([[String: String]](), error)
            }
        }
    }
    
    func parseJSON(json: JSON) -> Array<Dictionary<String, String>> {
        var expressionDetails = [[String: String]]()
        
        if(json["entry"].exists()) {
            for (index,_):(String, JSON) in json["entry"]["sense"] {
                var expr: [String: String] = [:]
                
                expr["definition"] = json["entry"]["sense"][Int(index)!]["def"].stringValue
                expr["genre"] = json["entry"]["sense"][Int(index)!]["gramGrp"].stringValue
                
                expressionDetails.append(expr)
            }
        } else if(json["superEntry"].exists()) {
            for (_,subJson):(String, JSON) in json["superEntry"] {
                for (index,_):(String, JSON) in subJson["entry"]["sense"] {
                    var expr: [String: String] = [:]
                    
                    expr["definition"] = subJson["entry"]["sense"][Int(index)!]["def"].stringValue
                    expr["genre"] = subJson["entry"]["sense"][Int(index)!]["gramGrp"].stringValue
                    
                    expressionDetails.append(expr)
                }
            }
        }
        
        return expressionDetails
    }
}
