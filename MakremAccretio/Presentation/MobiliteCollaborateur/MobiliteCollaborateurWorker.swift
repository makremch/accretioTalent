//
//  MobiliteCollaborateurWorker.swift
//  MakremAccretio
//
//  Created by Makrem on 3/2/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit
import Promise

class MobiliteCollaborateurWorker {

    // MARK: - Properties

    typealias Models = MobiliteCollaborateurModels

    // MARK: - Methods

    // MARK: Screen Specific Validation

    func validate(exampleVariable: String?) -> Models.MobiliteCollaborateurError? {
        var error: Models.MobiliteCollaborateurError?

        if exampleVariable?.isEmpty == false {
            error = nil
        } else {
            error = Models.MobiliteCollaborateurError(type: .emptyExampleVariable)
        }

        return error
    }
    
    func getListMobilityCollaborator(token : String) -> Promise<Response> {
        return MobiliteAPI.showListMobilityCollaborator(token: token)
    }
    
    
   
    
    		
}
