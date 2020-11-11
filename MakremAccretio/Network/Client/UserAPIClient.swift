//
//  UserAPIClient.swift
//  MakremAccretio
//
//  Created by Makrem on 2/19/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Alamofire
import Promise
class UserAPIClient: APIClient {
    
    
    static func login(username: String, password: String, grantType: String, clientName: String) -> Promise<UserSession> {

//        return performRequest(route: UserEndpoint.login(username: username, password: password, grantType: grantType, clientName: "accretio-2-tnr"))
        return performRequest(route: UserEndpoint.login(username: username, password: password, grantType: grantType, clientName: "mobile-int"))
        
//mobile-int
//        return performRequest(route: UserEndpoint.login(username: username, password: password, grantType: grantType, clientName: "tnr"))
        
    }
    
   
    
    static func me(token: String) -> Promise<User> {
//        let userDefault = UserDefaults.standard
//        let authorization = "Basic YWR2eXRlYW06YWRtaW4="
        let Cookie = "hazelcast.sessionId=HZC283098FD7A34E428B9EB9FE66EE1C9E"
        let url = Keys.MobileIntegrationServer.baseURL+"core/api/users/me"
        return  Promise<User> { fulfill, reject in
            AF.request(url, method: .get,  encoding: JSONEncoding.default, headers: [
                "authorization": "Bearer " + token,
                //"Content-Type": contentType,
                "Cookie": Cookie
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<User, AFError>) in
                print("me API")
                print(response.response?.statusCode as Any)
                switch response.result {
                case .success(let value):
                    print(value)
                    fulfill(value)
                    print("--------------------------------------------------")
                    print(response.description)
                    print("----------------------------------------")
                case .failure(let error):
                    
                    reject(error)
                }
            })
        }
        
    }
    
    static func profile (token : String, id : String) -> Promise<Profile>{
        let Cookie = "hazelcast.sessionId=HZC283098FD7A34E428B9EB9FE66EE1C9E"
        let url = "https://mobile-int.accretio.io/core/api/smartEmployeeProfile/" + id
        return  Promise<Profile> { fulfill, reject in
            AF.request(url, method: .get,  encoding: JSONEncoding.default, headers: [
                "authorization": "Bearer " + token,
                //"Content-Type": contentType,
                "Cookie": Cookie
            ]).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<Profile, AFError>) in
                print("me API")
                print(response.response?.statusCode as Any)
                switch response.result {
                case .success(let value):
                    print(value)
                    fulfill(value)
                    print("--------------------------------------------------")
                    print(response)
                    print("----------------------------------------")
                case .failure(let error):
                    
                    reject(error)
                }
            })
        }
    }
    
    
   static func postuler(attachedFile: [String?] = []) ->   Promise<DataResponse<Data?, AFError>>  {
             
            return performFullResponseRequest(route: MobiliteEndpoint.postuler(documentsCodes: attachedFile))
        }
    
    static func uploadFile(fileMultipart: MultipartFormData) -> Promise<FileResponses> {
        return performUploadRequest(route: MobiliteEndpoint.uploadFile, multipartFormData: fileMultipart) 
    }
}

