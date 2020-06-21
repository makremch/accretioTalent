//
//  MobiliteEndpoint.swift
//  MakremAccretio
//
//  Created by yakoubi mohammed on 4/2/20.
//  Copyright © 2020 Makrem. All rights reserved.
//


import Foundation
import Alamofire



enum MobiliteEndpoint: APIConfiguration {
    
    
    case postuler(documentsCodes: [String?] = [])
     case uploadFile
    var method: HTTPMethod {
        switch self {
        case .postuler, .uploadFile:
            return .post
        default:
            return .get
        }
    }
    
    var path: String{
        switch self {
            
        case .postuler(_):
            return "https://mobile-int.accretio.io/recruitment/api/candidatures"
        case .uploadFile:
        return "https://mobile-int.accretio.io/documentsmanagement/api/create/recruitment?isPublic=false"
        }
    }
    var parameters: Parameters?{
        switch self {
        case .postuler(let documentsCodes):
            let object = NSMutableDictionary()
            object.setValue("recruitmentCandidateModel", forKey: "codeModel")
            
            object.setValue("315485f5-cfbc-47d7-98e3-a7b047c67129", forKey: "codeCurriculumVitae")
            object.setValue("fd261114-1598-4cfa-8f1b-aa9938a14ad4", forKey: "codeRecruitmentOffer")
            object.setValue("2020-04-02T20:07:43.988Z", forKey: "candidatureDate")
            object.setValue(false, forKey: "mailSentFlag")
            object.setValue(true, forKey: "managerApproval")
            object.setValue("RECUE", forKey: "status")
            object.setValue("azerty", forKey: "createdBy")
            object.setValue("IN_PROG", forKey: "status")
            object.setValue("test", forKey: "motivation")
            object.setValue(documentsCodes, forKey: "documentsCodes")
            
            print(object)
            return (object as! Parameters)
            
        default:
            return nil
            
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var useParams = true
        var url = try "https://mobile-int.accretio.io/recruitment/api/candidatures".asURL()
        switch self {
               case .uploadFile:
                   url = try "https://mobile-int.accretio.io/documentsmanagement/api/create/recruitment?isPublic=false".asURL()
                   print(url)
               default:
                   url = try "https://mobile-int.accretio.io/recruitment/api/candidatures".asURL()
               }
        
        var urlRequest = URLRequest(url: url)
        switch self {
            
        case .postuler:
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            urlRequest.setValue(Connected.tokenHeader, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
            urlRequest.setValue(Connected.userSession?.userLanguage ?? "FR", forHTTPHeaderField: HTTPHeaderField.language.rawValue)
        case .uploadFile:
            urlRequest.setValue(Connected.tokenHeader, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
                   urlRequest.setValue(ContentType.multipartFormData.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
                   urlRequest.setValue(Connected.documentToken, forHTTPHeaderField: "Cookie")
        @unknown default:
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
        if(useParams) {
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        }
        print(url.absoluteString)
        return urlRequest
        
    }
}
