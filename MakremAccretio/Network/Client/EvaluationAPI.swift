//
//  EvaluationAPI.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/5/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation
import Alamofire
import Promise



class EvaluationAPI {
    
    
    static func showEvaluationCollaborateur(token : String) -> Promise<EvaluationResponse>{
        //        let url = "https://mobile-int.accretio.io/skills/api/skills"
        let url = "https://accretio-2-tnr.advyteam.com/evaluation/api/evaluated-historic-card/evaluated/me?size=10&page=0&stepKey=history"
        print(url)
        return  Promise<EvaluationResponse> { fulfill, reject in
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: [
                
                "Authorization": "Bearer " + token
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<EvaluationResponse, AFError>) in
                print(response)
                switch response.result {
                case .success(let value):
                    print(value)
                    fulfill(value)
                case .failure(let error):
                    print(error)
                    reject(error)
                }
            })
        }
    }
    
    
}
