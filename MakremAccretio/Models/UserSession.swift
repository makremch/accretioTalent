//
//  UserSession.swift
//  MakremAccretio
//
//  Created by Makrem on 2/19/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation


 struct UserSession: Codable {
    let accessToken: String
    let clientId: String
    let registrationNumber: String
    let scope: String
    let tokenType: String
    let userID: String
    let userLanguage: String
    var documentToken: String?
    let cookie: String?
    let expiresIn: Int
}



extension UserSession {
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case clientId
        case registrationNumber
        case scope
        case tokenType = "token_type"
        case userID
        case userLanguage
        case documentToken
        case cookie
        case expiresIn = "expires_in"
    }
}
