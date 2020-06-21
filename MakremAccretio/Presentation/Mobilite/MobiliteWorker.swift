//
//  MobiliteWorker.swift
//  MakremAccretio
//
//  Created by Makrem on 2/20/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit
import Promise


class MobiliteWorker {

    // MARK: - Properties

    typealias Models = MobiliteModels

    // MARK: - Methods

    // MARK: Screen Specific Validation

    func validate(exampleVariable: String?) -> Models.MobiliteError? {
        var error: Models.MobiliteError?

        if exampleVariable?.isEmpty == false {
            error = nil
        } else {
            error = Models.MobiliteError(type: .emptyExampleVariable)
        }

        return error
    }
    
    func getListMobility(token : String , isManager : Bool = false) -> Promise<DemandeResponse> {
        
        return MobiliteAPI.showListMobility(token:token)
    }
    
    func getListMobilityForValidation(token : String) -> Promise<DemandeResponse>{
        return MobiliteAPI.showListMobilityForValidation(token: token)
    }
}
