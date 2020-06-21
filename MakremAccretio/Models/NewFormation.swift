//
//  NewFormation.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 5/5/20.
//  Copyright © 2020 Makrem. All rights reserved.
//


import Foundation

// MARK: - Newcatalogue
struct Newcatalogue: Codable {
    let importance: String
    let targetEmployees: [InitiatorNewCatalogue]
    let newcatalogueDescription: String
    let priority: Bool
    let status, creationDate, limitDate, label: String
    let decision: JSONNull?
    let initiator: InitiatorNewCatalogue
    let initiatorType: String
    let isOutOfCatalog: Bool
    let codeModel: String
    let trainingOfferCode: TrainingOfferCode
}

// MARK: - Initiator
struct InitiatorNewCatalogue: Codable {
    let registrationNumber: String
}

// MARK: - TrainingOfferCode
struct TrainingOfferCode: Codable {
    let code: JSONNull?
}

// MARK: - Encode/decode helpers


