//
//  MobiliteAPI.swift
//  MakremAccretio
//
//  Created by Makrem on 2/20/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation
import Alamofire
import Promise


class MobiliteAPI {

    
    
    
//    static func showListOffersCollaborateur(page: Int, size: Int, sort: Int) -> Promise<Response> {
//
//        return performRequest(route: TalendEndpoint.mobiliteCollaborateur(page, size, sort))
//
//    }
    
    static func showListMobilityForValidation(token : String) -> Promise<DemandeResponse>{
        let url = "https://mobile-int.accretio.io/recruitment/api/recruitment-request/validator?roles=ROLE_MANAGER&size=5&page=0"
//        let url="https://accretio-2-tnr.advyteam.com/recruitment/api/recruitment-request/validator?roles=ROLE_MANAGER&size=5&page=0"
        return  Promise<DemandeResponse> { fulfill, reject in
            AF.request(url, method: .get,  encoding: JSONEncoding.default, headers: [
                "Authorization": "Bearer " + token
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<DemandeResponse, AFError>) in
                    print("Demande API")
                    print(response.response?.statusCode as Any)
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
    
//    static func showListMobility(token: String) -> Promise<DemandeResponse> {
//
//        let url = "https://mobile-int.accretio.io/recruitment/api/recruitment-offers/initiator?size=50&page=0"
//        return  Promise<DemandeResponse> { fulfill, reject in
//            AF.request(url, method: .get,  encoding: JSONEncoding.default, headers: [
//                "Authorization": "Bearer " + token
//                //"Content-Type": contentType,
//            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<DemandeResponse, AFError>) in
//                    print("Demande API")
//                    print(response.response?.statusCode as Any)
//                    switch response.result {
//
//                    case .success(let value):
//                        print(value)
//                        fulfill(value)
//
//                    case .failure(let error):
//                        print(error)
//                        reject(error)
//                    }
//                })
//        }
//
//    }
    
    
    static func showListMobility(token: String , isManager : Bool = false) -> Promise<DemandeResponse> {
        let url = "https://mobile-int.accretio.io/recruitment/api/recruitment-offers/initiator?size=50&page=0"
        
        return  Promise<DemandeResponse> { fulfill, reject in
            AF.request(url, method: .get,  encoding: JSONEncoding.default, headers: [
                "Authorization": "Bearer " + token
                //"Content-Type": contentType,
            ])
                //                .responseJSON(completionHandler: { (response) in
                //                    print(response)
                //            })
                
                .responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<DemandeResponse, AFError>) in
                    print("Demande API")
                    print(response.response?.statusCode as Any)
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
    
    
    
    static func showListMobilityCollaborator(token: String) -> Promise<Response>{
        let url = "https://mobile-int.accretio.io/recruitment/api/published-recruitment-offers"
        print(url)
        let params: [String: String] = ["":""]
        return Promise<Response>{ fulfill, reject in
            
            AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default,
                       headers: [
                        "Authorization":"Bearer " + token,
                        "content-type":"application/json"
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: {(response: DataResponse<Response, AFError>)
                in
                switch response.result {
                case .success(let value):
                    fulfill(value)
                case .failure(let error):
                    print(error)
                    reject(error)
                }
            })
            
        }
    }
    
    
    static func getCodeCV(token: String) -> Promise<CodeCv>{
        let registrationNumber = UserDefaults.standard.string(forKey: "registrationNumber")!
    let urlCodeCV = "https://mobile-int.accretio.io/recruitment/api/curriculumVitae/read/registrationNumber?registrationNumber=" + registrationNumber
        print(urlCodeCV)
        return Promise<CodeCv>{
            fulfill, reject in
            AF.request(urlCodeCV, method: .get, encoding: JSONEncoding.default, headers:
                ["Authorization":"Bearer " + token,
                 "content-type":"application/json"]
            ).responseDecodable(completionHandler: {(
                response: DataResponse<CodeCv, AFError>)
                in switch response.result{
                case .success(let value):
                    fulfill(value)
                case .failure(let error):
                    reject(error)
                }
            })
        }
        
    }
    
    			
    static func verifPostulerOffreByCollaborator(token : String, codeCV : String) -> Promise<ResponseVerif>{
        let url = "https://mobile-int.accretio.io/recruitment/api/candidatures/cv/"+codeCV
//        recruitment/api/candidatures/cv/{cvCode}
        print(url)
        return Promise<ResponseVerif> {
            fulfill, reject in
            AF.request(url,method: .get,encoding: JSONEncoding.default,
                       headers: [
                        "Authorization":"Bearer "+token,
                        "content-type":"application/json"
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: {(
                response: DataResponse<ResponseVerif, AFError>
                )in
                switch response.result{
                case .success(let value):
                    fulfill(value)
                case .failure(let error):
                    print(error)
                    reject(error)
                }
                
            })
        }
        
    }
    
    static func showListMobilityByManager(token: String) -> Promise<DemandeResponse> {
        let url = "https://mobile-int.accretio.io/recruitment/api/recruitment-request/validator?roles=ROLE_MANAGER&size=5&page=0"
        return  Promise<DemandeResponse> { fulfill, reject in
            AF.request(url, method: .get,  encoding: JSONEncoding.default, headers: [
                "Authorization": "Bearer " + token
                //"Content-Type": contentType,
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<DemandeResponse, AFError>) in
                    print("Demande API")
                    print(response.response?.statusCode as Any)
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
    
//    static func showListFormationCollaborateur(token: String) -> Promise<Formation> {
//        let url = "https://mobile-int.accretio.io/recruitment/api/recruitment-request/validator?roles=ROLE_MANAGER&size=5&page=0"
//        return  Promise<Formation> { fulfill, reject in
//            AF.request(url, method: .get,  encoding: JSONEncoding.default, headers: [
//                "Authorization": "Bearer " + token
//                //"Content-Type": contentType,
//            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<Formation, AFError>) in
//                    print("Demande API")
//                    print(response.response?.statusCode as Any)
//                    switch response.result {
//                        
//                    case .success(let value):
//                        print(value)
//                        fulfill(value)
//                        
//                    case .failure(let error):
//                        print(error)
//                        reject(error)
//                    }
//                })
//        }
//        
//    }
    
    
    
    
    
    
}
    
   
    

