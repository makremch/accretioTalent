//
//  AddCatalogueFormationRequest.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 8/10/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation

// MARK: - TrainingRequestModel
struct TrainingRequestModelAdd: Codable {
    internal init() {
        self.importance = ""
        self.targetEmployees = []
        self.trainingRequestModelDescription = ""
        self.priority = false
        self.status = ""
        self.creationDate = ""
        self.limitDate = ""
        self.label = ""
        self.decision = nil
        self.initiator = InitiatorSessionRequest()
        self.initiatorType = "InitiatorSession"
        self.isOutOfCatalog = true
        self.codeModel = "trainingRequestModel"
    }
    
    var importance: String?
    var targetEmployees: [InitiatorSessionRequest]?
    var trainingRequestModelDescription: String?
    var priority: Bool?
    var status, creationDate, limitDate, label: String?
    var decision: JSONNull?
    var initiator: InitiatorSessionRequest?
    var initiatorType: String?
    var isOutOfCatalog: Bool?
    var codeModel: String?

    enum CodingKeys: String, CodingKey {
        case importance, targetEmployees
        case trainingRequestModelDescription = "description"
        case priority, status, creationDate, limitDate, label, decision, initiator, initiatorType, isOutOfCatalog, codeModel
    }
}


struct InitiatorSessionRequest: Codable {
    internal init(registrationNumber: String?) {
        self.registrationNumber = registrationNumber
    }
    
    
    internal init() {
        self.registrationNumber = ""
    }

    
    let  registrationNumber: String?
}
