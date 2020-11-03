//
//  responseOfAdd.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 9/12/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation


// MARK: - ResponseAdding
struct ResponseAdding: Codable {
    let id, code, creationDate: String?
    let initiator: Initiator?
    let initiatorType: String?
    let trainingOfferCode: JSONNull?
    let targetEmployees: [Initiator]?
    let importance: String?
    let priority: Bool?
    let limitDate, responseAddingDescription, status: String?
    let currentStep, codeModel, trainingPlanCode, processID: JSONNull?
    let isOutOfCatalog: Bool?
    let label: String?

    enum CodingKeys: String, CodingKey {
        case id, code, creationDate, initiator, initiatorType, trainingOfferCode, targetEmployees, importance, priority, limitDate
        case responseAddingDescription = "description"
        case status, currentStep, codeModel, trainingPlanCode
        case processID = "processId"
        case isOutOfCatalog, label
    }
}


