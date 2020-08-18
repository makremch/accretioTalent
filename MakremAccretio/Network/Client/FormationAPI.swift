//
//  FormationAPI.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 4/27/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation
import Alamofire
import Promise




class FormationAPI {
    
    
    //    MARK:- affichage liste formation du manager
    static func showListFormationManager(token : String) -> Promise<ResponseFormation>{
        let registrationNumber = UserDefaults.standard.string(forKey: "registrationNumber")!
        //        let url = "https://mobile-int.accretio.io/training/api/training-participation-requests/initiator/" + registrationNumber + "?size=10&page=0&sort=creationDate,DESC"
        let url = "https://accretio-2-tnr.advyteam.com/training/api/training-participation-requests/initiator/" + registrationNumber + "?size=10&page=0&sort=creationDate,DESC"
        
        return  Promise<ResponseFormation> { fulfill, reject in
            AF.request(url, method: .get,  encoding: JSONEncoding.default, headers: [
                "Authorization": "Bearer " + token
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<ResponseFormation, AFError>) in
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
    
    
    
    //    MARK: affichage liste formation a valider Manager
    
    
    static func showListFormationManagerMesDemandes(token : String) -> Promise<ResponseFormation>{
        let registrationNumber : String = UserDefaults.standard.string(forKey: "registrationNumber")!
        print(registrationNumber)
        let url = "https://mobile-int.accretio.io/training/api/training-participation-requests/initiator/"+registrationNumber+"?size=10&page=0&sort=creationDate,DESC"
        //        let url = "https://mobile-int.accretio.io/training/api/training-participation-requests/initiator/06?size=10&page=0&sort=creationDate,DESC"
        return  Promise<ResponseFormation> { fulfill, reject in
            AF.request(url, method: .get,  encoding: JSONEncoding.default, headers: [
                "Authorization": "Bearer " + token
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<ResponseFormation, AFError>) in
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
    
    
    
    static func showMyActions(token : String)-> Promise<ResponseAction>{
        
        let url = "https://mobile-int.accretio.io/training/api/training-offers/search?page=0&size=10&sort=creationDate,DESC"
        
        return  Promise<ResponseAction> { fulfill, reject in
            AF.request(url, method: .get,  encoding: JSONEncoding.default, headers: [
                "Authorization": "Bearer " + token
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<ResponseAction, AFError>) in
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
    
    
    static func showCatalogueFormation(token : String) ->Promise<ResponseCatalogue>{
//        let base = "https://mobile-int.accretio.io/"
        let base = "https://accretio-2-tnr.advyteam.com/"
        let url = base + "training/api/training-offers/search?page=0&size=10&sort=creationDate,DESC"
        let params: [String: String] = ["":""]
        return  Promise<ResponseCatalogue> { fulfill, reject in
            AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [
                "content-type":"application/json",
                "Authorization": "Bearer " + token
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<ResponseCatalogue, AFError>) in
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
    
    
    static func showListFormationCollaborateur(token : String) -> Promise<ResponseFormationCollaborateur>{
        let base = "https://accretio-2-tnr.advyteam.com/"
//        let base = "https://mobile-int.accretio.io/"
        let registrationNumber = UserDefaults.standard.string(forKey: "registrationNumber")
        let url = base + "training/api/training-action/participants?targetEmployees="+registrationNumber!+"&size=50&page=0"
        
        return  Promise<ResponseFormationCollaborateur> { fulfill, reject in
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: [
                "Authorization": "Bearer " + token
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<ResponseFormationCollaborateur, AFError>) in
                switch response.result {
                    
                case .success(let value):
                    
                    print(response.response?.statusCode as Any)
                    print("________________________________")
                    print(value)
                    
                    fulfill(value)
                    
                case .failure(let error):
                    print(error)
                    reject(error)
                }
            })
        }
    }
    
    static func gettingFormationCatalogueById(token : String, code : String) -> Promise<FormationCatalogueDetails>{
        let base = "https://accretio-2-tnr.advyteam.com/"
        //        let base = "https://mobile-int.accretio.io/"
        let url = base + "training/api/training-offers/code/"+code
        return  Promise<FormationCatalogueDetails> { fulfill, reject in
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: [
                "Authorization": "Bearer " + token
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<FormationCatalogueDetails, AFError>) in
                switch response.result {
                    
                case .success(let value):
                    
                    print(response.response?.statusCode as Any)
                    print("________________________________")
                    print(value)
                    
                    fulfill(value)
                    
                case .failure(let error):
                    print(error)
                    reject(error)
                }
            })
        }
    }
    
        static func showListPopulation(token : String) -> Promise<Population>{
            let baseURL = "https://accretio-2-tnr.advyteam.com/"
    //        let base = "https://mobile-int.accretio.io/"
            let registrationNumber = UserDefaults.standard.string(forKey: "registrationNumber")!
            let url = baseURL + "core/api/employees/employeeforabsence/manager/" + registrationNumber + "/100"
            return  Promise<Population> { fulfill, reject in
                AF.request(url, method: .get, encoding: JSONEncoding.default, headers: [
                    "Authorization": "Bearer " + token
                ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<Population, AFError>) in
                    switch response.result {
                        
                    case .success(let value):
                        
                        print(response.response?.statusCode as Any)
                        print("________________________________")
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


