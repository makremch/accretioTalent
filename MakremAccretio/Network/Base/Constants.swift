//
//  Constants.swift
//  MakremAccretio
//
//  Created by Makrem on 2/19/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation
enum Keys {
    enum MobileIntegrationServer {
        static let baseURL = "https://mobile-int.accretio.io/"
//        static let baseURL = "https://accretio-2-tnr.advyteam.com/"
    }
    enum FilesBaseUrl {
        fileprivate static let url = Connected.companyConfig!.url
        static let timelineImageUrl = url + "/documentsmanagement/api/document-mgm?moduleName=timeline&codeFile="
        static let timelineVideoUrl = url + "/documentsmanagement/api/video/load-by-code?moduleName=timeline&codeFile="
        static let profileImageUrl = url + "/documentsmanagement/api/document-mgm?moduleName=corerh&codeFile="
    }
    enum LoginParameterKey {
        static let password = "password"
        static let email = "username"
        static let grantType = "grant_type"
        static let clientName = "clientName"
    }
    enum FirebaseParameterKey {
        static let token = "fcmToken"
        static let objects = "objects"
        static let registrationIds = "registrationIds"
        static let platform = "platform"
    }
    enum EmployeeParameterKey {
        static let registrationNumbers = "registrationNumbers"
    }
    enum ChatParameterKey {
        static let content = "content"
        static let sender  = "sender"
        static let receiver = "receiver"
        static let page = "page"
        static let sort = "sort"
        static let size = "size"
        static let body = "body"
        static let id = "id"
        static let date = "date"
        static let registrationNumber = "registrationNumber"
    }
    enum TimelineParameterKey {
        static let page = "page"
        static let sort = "sort"
        static let size = "size"
        static let postId = "postId"
        static let commentId = "commentId"
        static let body = "body"
        static let id = "id"
        static let date = "date"
        static let registrationNumber = "registrationNumber"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case typeRequest = "typeRequest"
    case gatewayKey = "x-gravitee-api-key"
    case companyCode = "companyCode"
    case cookie = "cookie"
    case language = "language"
}

enum ContentType: String {
    case json = "application/json"
    case formEncoded = "application/x-www-form-urlencoded"
    case multipartFormData = "multipart/form-data"
}
enum GraviteeKeys: String {
    case DocMangKey = "9764bbe4-26fe-457d-bc17-c2bdfe338f41"
    case FactKey = "837ac88c-1e99-4e34-be6e-64ff0ba92327"
    case DataTrans = "3bc547ff-52c8-42c4-a121-a8d7c8f78906"
    case CollabSpaceKey = ""
}
enum Authentication: String {
    case globalBasic = "Basic YWR2eXRlYW06YWRtaW4="
}
enum NotificationSource: String {
    case collabSpace = "collaborativeSpace"
    case fact = "fact"
}
enum Connected {
    static var notifCounterId = ""
    static var userSession: UserSession?
    static var documentToken: String = ""
    static var bnesDocumentToken: String?
    static var companyConfig: CompanyConfig?
    static var me: User?
    static var tokenHeader: String {
        let token = UserDefaults().string(forKey: "accessToken")!
        if userSession == nil {
            return "Bearer "+(token)
        } else {
            return userSession!.tokenType + " " + userSession!.accessToken
        }
    }
}
