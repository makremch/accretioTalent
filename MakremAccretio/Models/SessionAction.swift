//
//  SessionAction.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 5/5/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation


// MARK: - ResponseAction
struct ResponseAction: Codable {
    let content: [ActionSession]
    let last: Bool?
    let totalElements, totalPages: Int?
    let first: Bool?
    let numberOfElements, size, number: Int?
}

// MARK: - Content
struct ActionSession: Codable {
    let code: String?
    let codeModel: JSONNull?
    let label: String?
    let codeRequest: JSONNull?
    let codeOffer, codeSession: String?
    let initiator: InitiatorSession?
    let contentDescription: JSONNull?
    let targetEmployee, trainingManager, targetEmployeeManager: InitiatorSession?
    let organisationalEntity: JSONNull?
    let unit: String?
    let duration: Int?
    let creationDate, statusAction: String?
    let registrarionTrainersSessions: [String]?
    let outOfCatalogue: Bool?
    let comments, trainingOrganizations: [JSONAny]?
    let registrationTrainerManagerOffer: String?
    let trainers: JSONNull?
    let sessionTrainersList: [InitiatorSession]?
    let persistanceFailureStatus: Bool?
    let operationRequest: JSONNull?
    let present: Bool?
    let instantSessionEvaluation, instantTrainerEvaluation, instantParticipantEvaluation, delayedParticipantEvaluation: String?
    let delayedParticipantSkillsEvaluation: String?
    let sessionTrainingOrganizations: [JSONAny]?
    let sessionStartDate, sessionEndDate: Int?
    let sessionLabel: String?
    
    
}

// MARK: - Initiator
struct InitiatorSession: Codable {
    let id, firstName, lastName, registrationNumber: String?
    let profilePicture, email: String?
    let affectation: AffectationSession?
}

// MARK: - Affectation
struct AffectationSession: Codable {
    let affectedPosition, affectedOrganizationalEntity: AffectedSession?
}

// MARK: - Affected
struct AffectedSession: Codable {
    let id, code, label: String?
}
