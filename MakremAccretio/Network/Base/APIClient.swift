//
//  APIClient.swift
//  MakremAccretio
//
//  Created by Makrem on 2/19/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation
import Promise
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}


class APIClient{
    
    @discardableResult
    static func performRequest<T: Decodable>(route: APIConfiguration, decoder: JSONDecoder = JSONDecoder())->Promise<T> {
        return Promise<T> { fulfill, reject in
            
            AF.request(route).responseDecodable(decoder: decoder, completionHandler: { (response: DataResponse<T, AFError>) in
                print(response)
                switch response.result {
                case .success(let value):
                    if let userRoute = route as? UserEndpoint {
                        switch userRoute {
                        case .login:
                            let text = (response.response?.allHeaderFields as? [String: String])!["Set-Cookie"]!
                            Connected.documentToken = text[text.range(of: "documentToken")!.lowerBound..<text.range(of: "GMT")!.lowerBound] + "GMT"
                        default :
                            break
                        }
                    }
                    
                    fulfill(value)
                case .failure(let error):
                    reject(error)
                }
            })
            
        }
    }
    
    @discardableResult
    static func performFullResponseRequest(route: APIConfiguration) -> Promise<DataResponse<Data?, AFError>> {
        return Promise<DataResponse<Data?, AFError>> { fulfill, reject in
            
                AF.request(route).response( completionHandler: { (response: DataResponse<Data?, AFError>) in
                              switch response.result {
                              case .success:
                                  if let userRoute = route as? UserEndpoint {
                                      switch userRoute {
                                      case .login:
                                          let text = (response.response?.allHeaderFields as? [String: String])!["Set-Cookie"]!
                                          Connected.documentToken = text[text.range(of: "documentToken")!.lowerBound..<text.range(of: "GMT")!.lowerBound] + "GMT"
                                      default :
                                          break
                                      }
                                  }
                                  fulfill(response)
                              case .failure(let error):
                                  reject(error)
                              }
                          })
            
        }
    }
    @discardableResult
         static func performUploadMobiliteRequest(route: APIConfiguration, multipartFormData: MultipartFormData)->Promise<AFDataResponse<String>> {
             return Promise<AFDataResponse<String>> { fulfill, reject in
             
                   AF.upload(multipartFormData: multipartFormData, with: route).responseString { response in
                                print(response.response?.statusCode)
                              print(response)
                              switch response.result {
                              case .success:
                                  fulfill(response)
                              case .failure(let error):
                                  reject(error)
                              }
                   }
               
           }
         }
    @discardableResult
       static func performUploadRequest<T: Decodable>(route: APIConfiguration, multipartFormData: MultipartFormData, decoder: JSONDecoder = JSONDecoder())->Promise<T> {
           return Promise<T> { fulfill, reject in
               
                   print(multipartFormData.contentType)
                   AF.upload(multipartFormData: multipartFormData, with: route).responseDecodable(decoder: decoder, completionHandler: { (response: DataResponse<T, AFError>) in
                                           print(response.response?.statusCode)
                                           print(response)
                                           print(response.result)
                                           switch response.result {
                                           case .success(let value):
                                               fulfill(value)
                                           case .failure(let error):
                                               reject(error)
                                           }
                                       })
              
           }
       }
       
    //MARK: manager
    public static var manager: Alamofire.Session = {
        let manager = Alamofire.Session()
        let certificates: [SecCertificate] = []
        let pinEvaluator = PinnedCertificatesTrustEvaluator(certificates: certificates,
                                                            acceptSelfSignedCertificates: true,
                                                            performDefaultValidation: false,
                                                            validateHost: false)
        let disableEvaluator = DisabledEvaluator()
        var url = Connected.companyConfig?.url ?? ""
        url =   url.replacingOccurrences(of: "https://", with: "")
        url =   url.replacingOccurrences(of: "http://", with: "")
        let trustManager = ServerTrustManager.init(evaluators:
            [ Connected.companyConfig?.url ?? "": pinEvaluator,
              url: disableEvaluator
        ])
        
        let sessionManager = Session.init(configuration: .default, serverTrustManager: trustManager)
        return sessionManager
    }()
    
    let authorization = "Basic YWR2eXRlYW06YWRtaW4="
    let Cookie = "hazelcast.sessionId=HZC283098FD7A34E428B9EB9FE66EE1C9E"
    var baseURL = "https://mobile-int.accretio.io/uaa/oauth/token?grant_type=password&username="
    //        =naimhoussemeddine.rihani@advyteam.com&password=mobile%262019&clientName=mobile-int"
    //  var headers = ["authorization": authorization , "Cookie": Cookie]
    
    
    
    //    func login(username: String, password: String, clientName: String,decoder: JSONDecoder = JSONDecoder()) ->  Promise<UserSession> {
    //
    //        var url = baseURL + username + "&password=" + password + "&clientName=" + clientName
    //        let params = ["a":"a"]
    //
    //
    //     AF.request(url, method: .get, encoding: JSONEncoding.default, headers:[
    //                            "Authorization" : "Bearer "+(self.preferences.string(forKey: "accessToken")! )]).responseJSON(completionHandler:{
    //                                (response) in
    //                                print(response)
    //                                print("-----------------------------------------------------")
    //                                self.secondConsume()
    //                                if response.response?.statusCode == 200 {
    //                                    guard let data = response.data else{
    //                                        //print("deuxieme url fonctionne ! ",response.data as Any)
    //                                        return
    //                                    }
    //                                    do {
    //                                        let dict = try JSONDecoder().decode(User.self, from: data)
    //                                        print(dict)
    //                                    } catch let error{
    //                                        print("erreurrrrr1", error)
    //                                    }
    //                                }
    //                            }
    //
    //
    //                        )
    //           }
    
    
}

// var tokenHeader: String {
//    if userSession == nil {
//        return "Bearer "+( UserDefaults.UserData.object(forKey: .authToken) as? String ?? "")
//    } else {
//        return userSession!.tokenType + " " + userSession!.accessToken
////        AF.request()
//    }
//}


//
//enum UserEndpoint: APIConfiguration {
//    case login(username:String, password:String, grantType:String, clientName:String)
//    case me
//    case hobbies
//    case profile(userId:String)
////    case updateProfile(profile: Profile, businessPhone: String, facebook: String, linkedIn: String, twitter: String)
//    case companyConfig(companyCode:String)
//    case getSmartEmployees(registrationNumbers:[String])
//    case getPaginatedSmartEmployees(page:Int, size:Int, sort:String)
//    case getManager(userId:String)
//    case getTeamMembers(userId:String)
//    case getNotifications(page:Int, size:Int)
//    case getNotification(id:String)
//    case getCollabSpaceNotification(id:String)
//    case getNotificationModel(language:String)
//    case registerFCMToken(fcmToken:String, platform:String)
//    case unregisterFCMToken(fcmToken:String)
//    case getNotSeen(RegistrationNumber:String)
//    case annuiareMembers(page: Int, size:Int, sort: String)
//    case searchAnnuaireMembers(page: Int, size: Int, sort: String, textSearch:String)
//    case translateCR(crName:String)
//    case resetNotificationsStats
//    case getPopulation(registrationNumber: String)
//
//    case GetTicketCategorys
//    case getAllGroupStatus
//    case loadTicketStatus
//    case loadTicketPriority
//    case loadTypeCategory
//    case loadAllTickets(page:Int, size:Int)
//
//
////    static let prefixabsence = (Connected.companyConfig?.absence_prefix)
//    static let endpointBaseUrl = "/core/api/"
//    static let factBaseUrl = "/fact/api/"
//    static let collabSpaceUrl = "/collaborativespace/api/"
//    static let dataTransBaseUrl = "/dataandtranslation/api/"
//    static let uaaBaseUrl = "/uaa/api/"
//
//    //Tickets
//    static let getTiketsGroupStatus = "/timeline/api/tickets/group-status/me"
//    static let getTikets = "/timeline/api/tickets/me"
//    static let getTiketsPriority = "/dataandtranslation/api/generic-crs/CRTicketPriority"
//    static let getTicketTypeCategory = "/dataandtranslation/api/generic-crs/CRTicketTypeCategory"
//    static let getTicketStatus = "/dataandtranslation/api/generic-crs/CRTicketStatus"
//    static let GetTicketCategory = "/dataandtranslation/api/cr-ticket-category"
//    static let PostTicket = "/timeline/api/tickets"
//
//    // MARK: - HTTPMethod
//    var method: HTTPMethod {
//        switch self {
//        case .login:
//            return .post
//        case .getSmartEmployees:
//            return .post
//        case .registerFCMToken:
//            return .post
//        case .unregisterFCMToken:
//            return .delete
//        case .searchAnnuaireMembers:
//            return .post
//        case .resetNotificationsStats:
//            return .put
////        case .updateProfile:
////            return .put
//        default:
//            return .get
//        }
//    }
//
//    // MARK: - Path
//    var path: String {
//        switch self {
//        case .login:
//            //            var urlComponents = URLComponents(string: "")!
//            //            urlComponents.queryItems = [
//            //                URLQueryItem(name: "username", value: "jsmith"),
//            //                URLQueryItem(name: "password", value: "password"),
//            //                URLQueryItem(name: "grant_type", value: grantType),
//            //                URLQueryItem(name: "clientName", value: client)
//            //            ]
//            //
//            //            let url = urlComponents.url!
//            return "/uaa/oauth/token"
//        //            ?username="+username+"&password="+password+"&grant_type="+grantType+"&clientName="+clientName
//        case .me:
//            return UserEndpoint.endpointBaseUrl+"users/"+Connected.userSession!.userID
//        ///core/api/employees/registrationNumber
//        case .profile(let userId):
//            // old smartEmployeeProfile
//            //  return UserEndpoint.endpointBaseUrl+"employees/registrationNumber/"+URLEncoding.httpBody.escape(registrationNumber)
//            return UserEndpoint.endpointBaseUrl+"smartEmployeeProfile/"+URLEncoding.httpBody.escape(userId)
////        case .updateProfile(_, _, _, _, _):
////            return UserEndpoint.endpointBaseUrl+"smartEmployeeProfile"
//        case .getManager(let userId):
//            return UserEndpoint.endpointBaseUrl+"smartEmployeeProfile/manager/"+URLEncoding.httpBody.escape(userId)
//        case .getTeamMembers(let userId):
//            return UserEndpoint.endpointBaseUrl+"smartEmployeeProfile/teamMembers/"+URLEncoding.httpBody.escape(userId)
//        case .companyConfig:
//            return "/conf/clientAdvancedConfig"
//        case .getSmartEmployees(let registrationNumbers):
//            return UserEndpoint.endpointBaseUrl+"getSmartEmployeesByRegistrationNumbers?page=0&size=" + String(describing: registrationNumbers.count)
//        case .getPaginatedSmartEmployees(let page, _, _):
//            return UserEndpoint.endpointBaseUrl + "smartEmployees?page="+String(describing: page)
//        case .getNotifications:
//            return UserEndpoint.factBaseUrl+"notifications/employee/"
//        case .getNotification(let id):
//            return UserEndpoint.factBaseUrl+"notifications/"+URLEncoding.httpBody.escape(id)
//        case .getNotificationModel(let language):
//            return UserEndpoint.dataTransBaseUrl+"models/language/notificationModel/"+language
//        case .hobbies:
//            return UserEndpoint.dataTransBaseUrl+"c-r-hobbies"
//        case .registerFCMToken:
//            return UserEndpoint.uaaBaseUrl+"registerFcmToken"
//        case .unregisterFCMToken:
//            return UserEndpoint.uaaBaseUrl+"unregisterFcmTokens"
//        case .getNotSeen(let RegistrationNumber):
//            return UserEndpoint.factBaseUrl+"fact-activities-customized/employee/"+URLEncoding.httpBody.escape(RegistrationNumber)
//        case .getCollabSpaceNotification(let id):
//            return UserEndpoint.collabSpaceUrl+"notification/findOne/?id="+URLEncoding.httpBody.escape(id)
//        case .annuiareMembers:
//            return UserEndpoint.endpointBaseUrl + "annuaireActiveEmployeesByPage"
//        case .searchAnnuaireMembers(let page, let size, _, _):
//            return UserEndpoint.endpointBaseUrl + "annuaireActiveEmployees?page=" + String(describing: page) + "&size=" + String(describing: size) + "&sort=firstName,asc&sort=lastName,asc"
//        case .translateCR(let crName):
//            return UserEndpoint.dataTransBaseUrl+"generic-crs/"+URLEncoding.httpBody.escape(crName)
//        case .resetNotificationsStats:
//            return UserEndpoint.factBaseUrl + "fact-activities-customized"
//        case .getPopulation(let RegistrationNumber):
//            return UserEndpoint.endpointBaseUrl + "populations/employee/"+URLEncoding.httpBody.escape(RegistrationNumber)
//        case .GetTicketCategorys:
//            return UserEndpoint.getTicketTypeCategory
//        case .getAllGroupStatus:
//            return UserEndpoint.getTiketsGroupStatus
//        case .loadTicketStatus:
//            return UserEndpoint.getTicketStatus
//        case .loadTicketPriority:
//            return UserEndpoint.getTiketsPriority
//        case .loadTypeCategory:
//            return UserEndpoint.getTicketTypeCategory
//        case .loadAllTickets(let page, let size):
//            return UserEndpoint.getTikets + "?page=" + String(describing: page) + "&size=" + String(describing: size)
//
//        }
//
//
//
//
//    }
//
//    // MARK: - Parameters
//    var parameters: Parameters? {
//        switch self {
//        case .login(let username, let password, let grantType, let clientName):
//            let object = NSMutableDictionary()
//            object.setValue(username, forKeyPath: Keys.LoginParameterKey.email)
//            object.setValue(password, forKeyPath: Keys.LoginParameterKey.password)
//            object.setValue(grantType, forKeyPath: Keys.LoginParameterKey.grantType)
//            object.setValue(clientName, forKeyPath: Keys.LoginParameterKey.clientName)
//            return (object as! Parameters)
////        case .getSmartEmployees(let registrationNumbers):
////            let object = NSMutableDictionary()
////            object.setValue(registrationNumbers, forKey: Keys.EmployeeParameterKey.registrationNumbers)
////            return (object as! Parameters)
////        case .getNotifications(let page, let size):
////            let object = NSMutableDictionary()
////            object.setValue(page, forKey: Keys.TimelineParameterKey.page)
////            object.setValue(size, forKey: Keys.TimelineParameterKey.size)
////            return (object as! Parameters)
////        case .registerFCMToken(let fcmToken, let platform):
////            let object = NSMutableDictionary()
////            object.setValue(fcmToken, forKey: Keys.FirebaseParameterKey.registrationIds)
////            object.setValue(platform, forKey: Keys.FirebaseParameterKey.platform)
////            return (object as! Parameters)
////        case .unregisterFCMToken(let fcmToken):
////            let object = NSMutableDictionary()
////            object.setValue(fcmToken, forKey: Keys.FirebaseParameterKey.registrationIds)
////            return (object as! Parameters)
////        case .annuiareMembers(let page, let size, let sort):
////            let object = NSMutableDictionary()
////            object.setValue(page, forKey: Keys.TimelineParameterKey.page)
////            object.setValue(size, forKey: Keys.TimelineParameterKey.size)
////            object.setValue(sort, forKey: Keys.TimelineParameterKey.sort)
////            return (object as! Parameters)
////        case .searchAnnuaireMembers(_, _, _, let textSearch):
////            let object = NSMutableDictionary()
////            object.setValue(textSearch, forKey: "codeAlphabetic")
////            object.setValue("", forKey: "codePosition")
////            object.setValue("", forKey: "codeOrganizationalEntity")
////            object.setValue("", forKey: "hobbies")
////            object.setValue("", forKey: "phoneNumber")
////            object.setValue("", forKey: "registrationNumber")
////            object.setValue("STA_ACT", forKey: "codeStatus")
////
////            return (object as! Parameters)
////        case .resetNotificationsStats:
////            let object = NSMutableDictionary()
////            object.setValue(Connected.userSession!.registrationNumber, forKey: "employee")
////            object.setValue(Connected.notifCounterId, forKey: "id")
////            object.setValue(0, forKey: "notSeenAlerts")
////            object.setValue(0, forKey: "notSeenIdea")
////            object.setValue(0, forKey: "notSeenNotifs")
////            object.setValue(nil, forKey: "notSeenTasks")
////            return (object as! Parameters)
////
//
//        default:
//            return nil
//        }
//    }
//    func asURLRequest() throws -> URLRequest {
//        let paramsAsString = false
//        var url = try (Keys.MobileIntegrationServer.baseURL + path).asURL()
//        switch self {
//        case .companyConfig:
//            url = try (Keys.MobileIntegrationServer.baseURL + path).asURL()
//            print(url)
//        default:
//            url = try (Connected.getCompanyConfig().url + path).asURL()
//        }
//        var useParams = true
//
//        var urlRequest = URLRequest(url: url)
//
//        // HTTP Method
//
//        //Specific Headers & form params
//        switch self {
//        case .login:
//            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
//            urlRequest.setValue(Authentication.globalBasic.rawValue, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
//            urlRequest.setValue("83d9d1bc-e58a-4cb5-a85d-5bd8a343aed5", forHTTPHeaderField: HTTPHeaderField.gatewayKey.rawValue)
//            urlRequest.setValue(ContentType.formEncoded.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
//            useParams = false
//        //7f510d31-d487-4d8d-8d44-239add70b28e
////        case .companyConfig(let companyCode):
////            urlRequest.setValue(companyCode, forHTTPHeaderField: HTTPHeaderField.companyCode.rawValue)
////        case .getNotifications:
////            urlRequest = URLRequest(url: try (urlRequest.url!.absoluteString + Connected.userSession!.registrationNumber).asURL())
////            urlRequest.setValue(GraviteeKeys.FactKey.rawValue, forHTTPHeaderField: HTTPHeaderField.gatewayKey.rawValue)
////            urlRequest.setValue(Connected.tokenHeader, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
////            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
////            urlRequest.setValue(ContentType.formEncoded.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
////            useParams = false
////        case .getNotification:
////            urlRequest.setValue(GraviteeKeys.FactKey.rawValue, forHTTPHeaderField: HTTPHeaderField.gatewayKey.rawValue)
////            urlRequest.setValue(Connected.tokenHeader, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
////            useParams = false
////        case .getNotificationModel:
////            urlRequest.setValue(Connected.tokenHeader, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
////            urlRequest.setValue(GraviteeKeys.DataTrans.rawValue, forHTTPHeaderField: HTTPHeaderField.gatewayKey.rawValue)
////        case .registerFCMToken:
////            //   paramsAsString = true
////            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
////            urlRequest.setValue(Connected.tokenHeader, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
////            urlRequest.setValue("83d9d1bc-e58a-4cb5-a85d-5bd8a343aed5", forHTTPHeaderField: HTTPHeaderField.gatewayKey.rawValue)
////        case .unregisterFCMToken:
////            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
////            urlRequest.setValue(Connected.tokenHeader, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
////            urlRequest.setValue("83d9d1bc-e58a-4cb5-a85d-5bd8a343aed5", forHTTPHeaderField: HTTPHeaderField.gatewayKey.rawValue)
////            urlRequest.setValue(ContentType.formEncoded.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
////            useParams = false
////        case .getCollabSpaceNotification:
////            urlRequest.setValue(GraviteeKeys.CollabSpaceKey.rawValue, forHTTPHeaderField: HTTPHeaderField.gatewayKey.rawValue)
////            urlRequest.setValue(Connected.tokenHeader, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
////            useParams = false
////        case .annuiareMembers:
////            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
////            urlRequest.setValue(Connected.tokenHeader, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
////            urlRequest.setValue("7f510d31-d487-4d8d-8d44-239add70b28e", forHTTPHeaderField: HTTPHeaderField.gatewayKey.rawValue)
////            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
////            useParams = false
////        case .searchAnnuaireMembers:
////            urlRequest.setValue(Connected.tokenHeader, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
////            urlRequest.setValue("7f510d31-d487-4d8d-8d44-239add70b28e", forHTTPHeaderField: HTTPHeaderField.gatewayKey.rawValue)
////            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
////
//        default :
//            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
//            urlRequest.setValue(Connected.tokenHeader, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
//            urlRequest.setValue("7f510d31-d487-4d8d-8d44-239add70b28e", forHTTPHeaderField: HTTPHeaderField.gatewayKey.rawValue)
//            urlRequest.setValue(Connected.userSession?.userLanguage ?? "FR", forHTTPHeaderField: HTTPHeaderField.language.rawValue)
//
//        }
//        urlRequest.httpMethod = method.rawValue
//
//        // Common Headers
//        //   urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
//
//        urlRequest.setValue("smart", forHTTPHeaderField: HTTPHeaderField.typeRequest.rawValue)
//        urlRequest.setValue("true", forHTTPHeaderField: "logging")
//
//        // Parameters
//        if(useParams) {
//            if(paramsAsString) {
//                //                switch self {
//                //                case .registerFCMToken(let fcmToken):
//                //                    urlRequest.httpBody = fcmToken.data(using: .utf8)
//                //                default :
//                //                    break
//                //                }
//            } else {
//                if let parameters = parameters {
//                    do {
//                        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
//                    } catch {
//                        throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
//                    }
//                }
//            }
//        }
//
//        print(url.absoluteString)
//        return urlRequest
//    }
//}
