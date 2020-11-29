//
//  MesDemandesFormation.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 28/11/2020.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation

// MARK: - Mes demandes formations
struct MesFromationResponse: Codable {
    let content: [DemandeFormation]?
    let totalElements: Int?
    let last: Bool?
    let totalPages: Int?
    let sort: [Sort]?
    let first: Bool?
    let numberOfElements, size, number: Int?
}

// MARK: - Content
struct DemandeFormation: Codable {
    let id,  creationDate: String?
    let initiator: Initiator?
    let initiatorType: String?
    let trainingOfferCode: TrainingOffersCode?
    let targetEmployees: [Initiator]?
    let importance: String?
    let priority: Bool?
    let limitDate, contentDescription, status: String?
    let currentStep, codeModel, trainingPlanCode, processID: String?
    let isOutOfCatalog: Bool?
    let label: String?

    
}


// MARK: - TrainingOfferCode
struct TrainingOffersCode: Codable {
    let documentsList: [JSONAny]?
    let id, code, label: String?
    let picture, theme, goals, program: JSONNull?
    let duration, unit, target, trainingType: JSONNull?
    let trainingOrganization, trainer, place, capacity: JSONNull?
    let certification: Bool?
    let costs: JSONNull?
    let publicationFlag, publishedForEmployees, publishedForManagers: Bool?
    let targetSkills, creationDate, initiator, codeModel: JSONNull?
    let trainingManager, average, documentsIDSList: JSONNull?

    enum CodingKeys: String, CodingKey {
        case documentsList, id, code, label, picture, theme, goals, program, duration, unit, target, trainingType, trainingOrganization, trainer, place, capacity, certification, costs, publicationFlag, publishedForEmployees, publishedForManagers, targetSkills, creationDate, initiator, codeModel, trainingManager, average
        case documentsIDSList = "documentsIdsList"
    }
}

// MARK: - Sort
struct Sort: Codable {
    let direction, property: String?
    let ignoreCase: Bool?
    let nullHandling: String?
    let ascending, descending: Bool?
}
