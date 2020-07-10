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
        //        let baseURL = "https://mobile-int.accretio.io/"
        let baseURL = "https://accretio-2-tnr.advyteam.com/"
        let url = baseURL + "evaluation/api/campaign/?userType=EMPLOYEE&size=5&page=0&roles=ROLE_USER"
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
    
    
    static func showEvaluationDetailsCollaborateur(token : String , code : String) -> Promise<EvaluationDetailsResponse>{
        let baseURL = "https://accretio-2-tnr.advyteam.com/"
        let registarionNumber = UserDefaults.standard.string(forKey: "registrationNumber")!
        let url = baseURL + "evaluation/api/evaluated-process-details/smartEvaluation/campaign/" + code + "/evaluated/" + registarionNumber
        
        print(url)
        return  Promise<EvaluationDetailsResponse> { fulfill, reject in
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: [
                
                "Authorization": "Bearer " + token
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<EvaluationDetailsResponse, AFError>) in
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
