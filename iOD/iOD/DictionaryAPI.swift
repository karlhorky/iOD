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
    
    func fetchLiteralExpression (keyword: String, completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
        let escapedQuery = keyword.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        makeRequest(keyword: keyword, url: "\(BASE_URL)\(escapedQuery!)", completionHandler: completionHandler)
    }
    
    func makeRequest(keyword: String, url: String, completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var expressionDetails: [String: String] = [:]
                
                expressionDetails["definition"] = json["entry"]["sense"][0]["def"].string
                expressionDetails["genre"] = (json["entry"]["sense"][0]["gramGrp"] == "m.") ? "Masculino" : "Feminino"
                
                completionHandler(expressionDetails as NSDictionary?, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
