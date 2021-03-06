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
//    let numberOfElements, size, number: String
}

// MARK: - Catalogue
struct FormationCatalogue: Codable {
    let id, code, label, picture: String?
    let theme, creationDate: String?
    let initiator: InitiatorCatalogue?
    let trainer: [TrainerCatalogue]?
    let  duration: Int?
    let unit: String?
    let numberParticipants: String?
    let trainingOrganization: [String]?
    let trainingManager: InitiatorCatalogue?
//    let average: JSONNull?
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
//    let average: JSONNull?
}


