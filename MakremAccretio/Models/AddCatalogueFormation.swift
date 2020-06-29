//
//  AddCatalogueFormation.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 6/28/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation


// MARK: - AddCatalogue
struct AddCatalogue: Codable {
    let importance: String
    let targetEmployees: [Initiator]
    let addCatalogueDescription: String
    let priority: Bool
    let status, creationDate, limitDate, label: String
    let decision: JSONNull?
    let initiator: Initiator
    let initiatorType: String
    let isOutOfCatalog: Bool
    let codeModel: String
    let trainingOfferCode: TrainingOfferCode
    
    enum CodingKeys: String, CodingKey {
        case importance, targetEmployees
        case addCatalogueDescription = "description"
        case priority, status, creationDate, limitDate, label, decision, initiator, initiatorType, isOutOfCatalog, codeModel, trainingOfferCode
    }
}

