//
//  UserEndpoint.swift
//  Accretio-X-ios
//
//  Created by Achref Gharbi on 4/24/19.
//  Copyright © 2019 Achref Gharbi. All rights reserved.
//

import Foundation
import Alamofire
enum UserEndpoint: APIConfiguration {
    case login(username:String, password:String, grantType:String, clientName:String)
    case me
    
    
    static let prefixabsence = (Connected.companyConfig?.absence_prefix)
    static let endpointBaseUrl = "/core/api/"
    static let factBaseUrl = "/fact/api/"
    static let collabSpaceUrl = "/collaborativespace/api/"
    static let dataTransBaseUrl = "/dataandtranslation/api/"
    static let uaaBaseUrl = "/uaa/api/"
    
    //Tickets
    static let getTiketsGroupStatus = "/timeline/api/tickets/group-status/me"
    static let getTikets = "/timeline/api/tickets/me"
    static let getTiketsPriority = "/dataandtranslation/api/generic-crs/CRTicketPriority"
    static let getTicketTypeCategory = "/dataandtranslation/api/generic-crs/CRTicketTypeCategory"
    static let getTicketStatus = "/dataandtranslation/api/generic-crs/CRTicketStatus"
    static let GetTicketCategory = "/dataandtranslation/api/cr-ticket-category"
    static let PostTicket = "/timeline/api/tickets"
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
       
            
        default:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .login:
            return "/uaa/oauth/token"
        case .me:
            return UserEndpoint.endpointBaseUrl+"users/"+Connected.userSession!.userID
        
        }
        
        
        
        
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .login(let username, let password, let grantType, let clientName):
            let object = NSMutableDictionary()
            object.setValue(username, forKeyPath: Keys.LoginParameterKey.email)
            object.setValue(password, forKeyPath: Keys.LoginParameterKey.password)
            object.setValue(grantType, forKeyPath: Keys.LoginParameterKey.grantType)
            object.setValue(clientName, forKeyPath: Keys.LoginParameterKey.clientName)
            print(object)
            return (object as! Parameters)
        
            
        default:
            return nil
        }
    }
    func asURLRequest() throws -> URLRequest {
        let paramsAsString = false
        let url = try (Keys.MobileIntegrationServer.baseURL + path).asURL()
        var useParams = true
       
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method
        
        //Specific Headers & form params
        switch self {
        case .login:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            urlRequest.setValue(Authentication.globalBasic.rawValue, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
            urlRequest.setValue("83d9d1bc-e58a-4cb5-a85d-5bd8a343aed5", forHTTPHeaderField: HTTPHeaderField.gatewayKey.rawValue)
            urlRequest.setValue(ContentType.formEncoded.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            useParams = false
        default :
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            urlRequest.setValue(Connected.tokenHeader, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
            urlRequest.setValue("7f510d31-d487-4d8d-8d44-239add70b28e", forHTTPHeaderField: HTTPHeaderField.gatewayKey.rawValue)
            urlRequest.setValue(Connected.userSession?.userLanguage ?? "FR", forHTTPHeaderField: HTTPHeaderField.language.rawValue)
            
        }
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        //   urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        urlRequest.setValue("smart", forHTTPHeaderField: HTTPHeaderField.typeRequest.rawValue)
        urlRequest.setValue("true", forHTTPHeaderField: "logging")
        
        // Parameters
        if(useParams) {
            if(paramsAsString) {
                //                switch self {
                //                case .registerFCMToken(let fcmToken):
                //                    urlRequest.httpBody = fcmToken.data(using: .utf8)
                //                default :
                //                    break
                //                }
            } else {
                if let parameters = parameters {
                    do {
                        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                    } catch {
                        throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                    }
                }
            }
        }
        print(url)
        return urlRequest
    }
}
