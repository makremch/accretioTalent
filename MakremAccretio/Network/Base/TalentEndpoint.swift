//
//  TalendEndpoint.swift
//  MakremAccretio
//
//  Created by Makrem on 3/4/20.
//  Copyright © 2020 Makrem. All rights reserved.
//


import Foundation
import Alamofire
enum TalentEndpoint: APIConfiguration {
    
    
//    MARK: - BaseEndPointTalent
    static let endpointBaseUrlTalent = "/recruitment/api/"
    static let getListMobilityAsCollaborator = "initiator"
    static let getListMobilityAsManager = "validator?roles=ROLE_MANAGER&size=5&page=0"

    case mobiliteCollaborateur(page: Int, size: Int, sort: String)
    case mobiliteManager(page: Int, size: Int, sort: String)

    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .mobiliteCollaborateur:
            return .post
        default:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        
        switch self {
        case .mobiliteCollaborateur:
            return TalentEndpoint.endpointBaseUrlTalent + TalentEndpoint.getListMobilityAsCollaborator
        
        case .mobiliteManager(let pagh, let size, let sort):
            return TalentEndpoint.endpointBaseUrlTalent + TalentEndpoint.getListMobilityAsManager
        }
    }
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .mobiliteCollaborateur(let page, let size, let sort):
            let object = NSMutableDictionary()
            object.setValue(size, forKeyPath: Keys.TimelineParameterKey.size)
            object.setValue(page, forKeyPath: Keys.TimelineParameterKey.page)
            object.setValue(sort, forKeyPath: Keys.TimelineParameterKey.sort)
            return (object as? Parameters)
        default:
            return nil
        }
    }
    
    
    
    func asURLRequest() throws -> URLRequest {
        var url = ""
        // let url = try (Connected.getCompanyConfig().url + path).asURL()
        var urlRequest = URLRequest(url: try! url.asURL())
        // HTTP Method
        var useParams = true
        var paramsAsString = false
        var isJsonObject = false
        //Specific Headers & form params
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        switch self {
        case .mobiliteCollaborateur(let page, let size, let sort):
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
            useParams = false
        
        default:
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            break
        }
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(Connected.tokenHeader, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        urlRequest.setValue("8966a221-4192-4935-82d4-ecad703d80e4", forHTTPHeaderField: HTTPHeaderField.gatewayKey.rawValue)
        //   urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        urlRequest.setValue("smart", forHTTPHeaderField: HTTPHeaderField.typeRequest.rawValue)
        urlRequest.setValue("true", forHTTPHeaderField: "logging")
        
        // Parameters
        if(useParams) {
//            if(paramsAsString) {
//                switch self {
//                case .toggleLike(let postId):
//                    urlRequest.httpBody = postId.data(using: .utf8)
//                    //                case .addCommentIdeation(_, let commentString, let taggedEmployees):
//                //                    urlRequest.httpBody = commentString.data(using: .utf8)
//                default :
//                    break
//                }
//            } else {
//                if let parameters = parameters {
//                    do {
//                        print(parameters)
//                        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
//                        //   urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options:
//                    } catch {
//                        throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
//                    }
//                }}
        } else if isJsonObject {
            switch self {
//            case .updatePost(let post,let taggedEmployees, _):
//                var tweakedPost = post
//                tweakedPost.taggedEmployees = taggedEmployees
//                let jsonEncoder = JSONEncoder()
//                let jsonData = try jsonEncoder.encode(tweakedPost)
//                urlRequest.httpBody = jsonData
//            case .updateIdea(let idea):
//                let jsonEncoder = JSONEncoder()
//                let jsonData = try jsonEncoder.encode(idea)
//                urlRequest.httpBody = jsonData
//            case .updateNews(let news):
//                let jsonEncoder = JSONEncoder()
//                let jsonData = try jsonEncoder.encode(news)
//                urlRequest.httpBody = jsonData
//            case .getResponseSurvey(let id):
//                let jsonEncoder = JSONEncoder()
//                let jsonData = try jsonEncoder.encode(id)
//                urlRequest.httpBody = jsonData
            
            default:
                break
            }
        }
        
        urlRequest.timeoutInterval = 60
        return urlRequest
    }
}
