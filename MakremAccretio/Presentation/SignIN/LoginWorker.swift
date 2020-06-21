//
//  LoginWorker.swift
//  MakremAccretio
//
//  Created by Makrem on 2/19/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit
import Promise

class LoginWorker {
    
    func login(username: String, password: String, clientCode: String ,
        grantType: String ) -> Promise<UserSession> {
        return UserAPIClient.login(username: username, password: password, grantType: grantType, clientName: clientCode)
    }
    
    func me(token : String) -> Promise<User> {
        return UserAPIClient.me(token: token)
    }
    // MARK: - Properties

    typealias Models = LoginModels

    // MARK: - Methods

    // MARK: Screen Specific Validation

    func validate(exampleVariable: String?) -> Models.LoginError? {
        var error: Models.LoginError?

        if exampleVariable?.isEmpty == false {
            error = nil
        } else {
            error = Models.LoginError(type: .emptyExampleVariable)
        }

        return error
    }
}
