//
//  CatalogueFormation.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 5/5/20.
//  Copyright © 2020 Makrem. All rights reserved.
//


import Foundation

// MARK: - ResponseCatalogue
struct ResponseCatalogue: Codable {
    let content: [FormationCatalogue]
    let totalPages: Int?
//    let first: Int
//    let numberOfElements, size, number: Int
}

// MARK: - Catalogue
struct FormationCatalogue: Codable {
    let id, code, label, picture: String?
    let theme, creationDate: String?
    let initiator: InitiatorCatalogue?
    let trainer: [TrainerCatalogue]?
    let costs, duration: Int?
    let unit: String?
    let numberParticipants: JSONNull?
    let trainingOrganization: [String]?
    let trainingManager: InitiatorCatalogue?
    let average: Int?
}

// MARK: - Initiator
struct InitiatorCatalogue: Codable {
    let id, firstName, lastName, registrationNumber: String?
    let profilePicture, email: String?
    let affectation: AffectationCatalogue?
}

// MARK: - Affectation
struct AffectationCatalogue: Codable {
    let affectedPosition, affectedOrganizationalEntity: AffectedCatalogue?
}

// MARK: - Affected
struct AffectedCatalogue: Codable {
    let id, code, label: String?
}

// MARK: - Trainer
struct TrainerCatalogue: Codable {
    let id, firstName, lastName, registrationNumber: String?
    let profilePicture, email: String?
    let affectation: JSONNull?
    let phone: String?
    let skills: [JSONAny]?
    let average: Int?
}


