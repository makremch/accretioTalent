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
    
    static func showListMobilityForValidation(token : String) -> Promise<DemandeResponse>{
        //        let base = "https://mobile-int.accretio.io/recruitment/"
        let base = "https://accretio-2-tnr.advyteam.com/ms-talent/"
//        let url = base + "api/recruitment-request/validator?roles=ROLE_MANAGER&size=5&page=0"
        let url = base + "api/recruitment-request/validator?roles=ROLE_MANAGER&size=5&page=0"
        print("url")
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
                    print("3asba for validation ")
                    
                case .failure(let error):
                    print(error)
                    reject(error)
                    print("3asbtin")
                }
            })
        }
    }
    
    
    static func showListMobility(token: String) -> Promise<DemandeResponse> {
        //        let base = "https://mobile-int.accretio.io/recruitment/"
        let base = "https://accretio-2-tnr.advyteam.com/ms-talent/"
//        let url = base + "api/recruitment-offers/initiator?size=50&page=0"
        let url = base + "api/recruitment-offers/initiator?size=50&page=0"
        print(url)
        return  Promise<DemandeResponse> { fulfill, reject in
            AF.request(url, method: .get,  encoding: JSONEncoding.default, headers: [
                "Authorization": "Bearer " + token
            ])
                .responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<DemandeResponse, AFError>) in
                    print("Demande API")
                    let statusCode = response.response?.statusCode
                    print(statusCode!)
                    switch response.result {
                        
                    case .success(let value):
                        let valueSuccess : String = "bien"
                        print(valueSuccess,value)
                        fulfill(value)
                    case .failure(let error):
                        let valueSuccess : String = "el 3asba"
                        print(error,valueSuccess)
                        reject(error)
                    }
                })
        }
        
    }
    
    
    
    static func showListMobilityCollaborator(token: String) -> Promise<Response>{
        //        let base = "https://mobile-int.accretio.io/"
        let base = "https://accretio-2-tnr.advyteam.com/ms-talent/"
        let url = base + "api/published-recruitment-offers"
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
        //        let base = "https://mobile-int.accretio.io/"
        let base = "https://accretio-2-tnr.advyteam.com/ms-talent/"
        let urlCodeCV = base + "recruitment/api/curriculumVitae/read/registrationNumber?registrationNumber=" + registrationNumber
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
                    print(response.result)
                    print("aaaa")
                case .failure(let error):
                    reject(error)
                }
            })
        }
        
    }
    
    
    static func verifPostulerOffreByCollaborator(token : String, codeCV : String) -> Promise<ResponseVerif>{
        //        let base = "https://mobile-int.accretio.io/"
        let base = "https://accretio-2-tnr.advyteam.com/ms-talent/"
        let url = base + "recruitment/api/candidatures/cv/"+codeCV
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
        //        let base = "https://mobile-int.accretio.io/"
        let base = "https://accretio-2-tnr.advyteam.com/ms-talent/"
        let url = base + "recruitment/api/recruitment-request/validator?roles=ROLE_MANAGER&size=5&page=0"
        print("url")
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
}




