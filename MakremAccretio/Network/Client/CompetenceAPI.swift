//
//  CompetenceAPI.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 6/3/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation
import Alamofire
import Promise




class CompetecenceAPI {
    
    static func showCompetenceCollaborateur(token : String) -> Promise<CompetenseResponse>{
        let params: [String: String] = ["":""]
        let url = "https://mobile-int.accretio.io/skills/api/affectation-skills-card?skillAffectationType=EMPLOYEE&referenceAffectationType=POSITION&page=0&size=6"
        //            let url2 = "https://accretio-2-tnr.advyteam.com/skills/api/skills"
        //        let url = "https://accretio-2-tnr.advyteam.com/skills/api/affectation-skills-card?skillAffectationType=EMPLOYEE&referenceAffectationType=POSITION&page=0&size=10"
        print(url)
        return  Promise<CompetenseResponse> { fulfill, reject in
            AF.request(url, method: .post, parameters: params,  encoding: JSONEncoding.default, headers: [
                "content-type":"application/json",
                "Authorization": "Bearer " + token
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<CompetenseResponse, AFError>) in
                switch response.result {
                    
                case .success(let value):
                    print(value)
                    print(response)
                    fulfill(value)
                case .failure(let error):
                    print(error)
                    reject(error)
                }
            })
        }
    }
    
    
    static func showCompetenceLabelCollaborateur(token : String) -> Promise<[CompetenseLabelResponseElement]>{
        let url = "https://mobile-int.accretio.io/skills/api/skills"
        print(url)
        return  Promise<[CompetenseLabelResponseElement]> { fulfill, reject in
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: [
                
                "Authorization": "Bearer " + token
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<[CompetenseLabelResponseElement], AFError>) in
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
