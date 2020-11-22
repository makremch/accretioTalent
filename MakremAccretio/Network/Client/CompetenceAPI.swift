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
        let registrationNumber : String = String(UserDefaults.standard.string(forKey: "registrationNumber")!)
        let params: [String: Any] = ["codeComponentList":[registrationNumber]]
        let url = "https://mobile-int.accretio.io/ms-talent/api/affectation-skills-card?skillAffectationType=EMPLOYEE&referenceAffectationType=POSITION&page=0&size=6"
//        let url = "https://accretio-2-tnr.advyteam.com/ms-talent/api/affectation-skills-card?skillAffectationType=EMPLOYEE&referenceAffectationType=POSITION&page=0&size=6"
        print(url)
        return  Promise<CompetenseResponse> { fulfill, reject in
            AF.request(url, method: .post, parameters: params,  encoding: JSONEncoding.default, headers: [
                "content-type":"application/json",
                "Authorization": "Bearer " + token
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<CompetenseResponse, AFError>) in
                switch response.result {
                    
                case .success(let value):
                    print("Hello")
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
        let url = "https://mobile-int.accretio.io/ms-talent/api/skills"
//        let url = "https://accretio-2-tnr.advyteam.com/ms-talent/api/skills"
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
    
    
    
    
    static func showCompetenceManager(token : String) -> Promise<CompetenseResponse>{
        let registrationNumber : String = String(UserDefaults.standard.string(forKey: "registrationNumber")!)
        let params: [String: String] = ["managerRegistrationNumber": registrationNumber]
        let url = "https://mobile-int.accretio.io/ms-talent/api/affectation-skills-card?skillAffectationType=EMPLOYEE&referenceAffectationType=POSITION&page=0&size=60"
//        let url = "https://accretio-2-tnr.advyteam.com/ms-talent/api/affectation-skills-card?skillAffectationType=EMPLOYEE&referenceAffectationType=POSITION&page=0&size=60"
        return  Promise<CompetenseResponse> { fulfill, reject in
            AF.request(url, method: .post, parameters: params,  encoding: JSONEncoding.default, headers: [
                "content-type":"application/json",
                "Authorization": "Bearer " + token
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<CompetenseResponse, AFError>) in
                switch response.result {
                    
                case .success(let value):
                    print(value)
                    print(value.content?.count as Any)
                    
                    fulfill(value)
                case .failure(let error):
                    print(error)
                    reject(error)
                }
            })
        }
    }
    
    static func showCompetenceLabelManager(token : String) -> Promise<[CompetenseLabelResponseElement]>{
           let url = "https://mobile-int.accretio.io/ms-talent/api/skills"
//        let url = "https://accretio-2-tnr.advyteam.com/ms-talent/api/skills"
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
    
    
    
    
    static func showCompetenceLevels(token : String, codeClassification : String) -> Promise<LevelResponse>{
        let url = "https://mobile-int.accretio.io/dataandtranslation/api/c-r-skills-levels/crSkillClassification/" + codeClassification
//        let url = "https://accretio-2-tnr.advyteam.com/ms-talent/api/skills"
        print(url)
        return  Promise<LevelResponse> { fulfill, reject in
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: [
                
                "Authorization": "Bearer " + token
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<LevelResponse, AFError>) in
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
    
    static func addCompetence(token : String,params : [String: Any]) ->Promise<ResponseAddingCompetence>{
        //        let url = base + "training/api/training-offers/search?page=" + String(page) + "&size=" + String(size) + "&sort=creationDate,DESC"
        let code : String = params["codeComponent"] as! String
        let url = "https://mobile-int.accretio.io/ms-talent/api/affectation-skills/" + code + "/skill?skillAffectationType=EMPLOYEE"
        
        print(url)
        return  Promise<ResponseAddingCompetence> { fulfill, reject in
            AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [
                "content-type":"application/json",
                "Authorization": "Bearer " + token
            ]).responseJSON { (responseInsert) in
                print((responseInsert.response?.statusCode)!)
                print("assba")
                    switch responseInsert.result {
                    
                    case .success(let value):
                        print("hello true !")
                        print(value)
                    case .failure(let error):
                        print("hello false !")
                        print(error)
                        reject(error)
                    }
            }
        }
    }
    
    
    
}
