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
    internal init(id: String?, firstName: String?, lastName: String?, registrationNumber: String?, profilePicture: String?, email: String?, affectation: AffectationSession?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.registrationNumber = registrationNumber
        self.profilePicture = profilePicture
        self.email = email
        self.affectation = affectation
    }
    
    internal init() {
        self.id = ""
        self.firstName = ""
        self.lastName = ""
        self.registrationNumber = ""
        self.profilePicture = ""
        self.email = ""
        self.affectation = AffectationSession()
    }

    
    let id, firstName, lastName, registrationNumber: String?
    let profilePicture, email: String?
    let affectation: AffectationSession?
}

// MARK: - Affectation
struct AffectationSession: Codable {
    internal init(affectedPosition: AffectedSession?, affectedOrganizationalEntity: AffectedSession?) {
        self.affectedPosition = affectedPosition
        self.affectedOrganizationalEntity = affectedOrganizationalEntity
    }
    internal init() {
        self.affectedPosition = AffectedSession()
        self.affectedOrganizationalEntity = AffectedSession()
    }
    let affectedPosition, affectedOrganizationalEntity: AffectedSession?
}

// MARK: - Affected
struct AffectedSession: Codable {
    internal init(id: String?, code: String?, label: String?) {
        self.id = id
        self.code = code
        self.label = label
    }
    
    internal init() {
        self.id = ""
        self.code = ""
        self.label = ""
    }
    
    let id, code, label: String?
}
