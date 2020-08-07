//
//  FormationCollaborateur.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 5/8/20.
//  Copyright © 2020 Makrem. All rights reserved.
//



import Foundation

// MARK: - ResponseFormationCollaborateur
struct ResponseFormationCollaborateur: Codable {
    let content: [CollaborateurFormation]
    let last: Bool?
    let totalElements, totalPages: Int?
    let first: Bool?
    let sort: JSONNull?
    let numberOfElements, size, number: Int?
}

// MARK: - Content formation des collaborateurs 
struct CollaborateurFormation: Codable {
    let code: String?
    let codeModel: JSONNull?
    let label: String?
    let codeRequest: JSONNull?
    let codeOffer: String?
    let codeSession: String?
    let initiator: InitiatorCollab?
    let contentDescription: String?
    let targetEmployee, trainingManager, targetEmployeeManager: InitiatorCollab?
    let organisationalEntity: JSONNull?
    let unit: String?
    let duration: Int?
//    let creationDate:String?
    let statusAction: String?
    let registrarionTrainersSessions: [String]?
    let outOfCatalogue: Bool?
//    let comments: [Comment]?
    let trainingOrganizations: [String]?
    let registrationTrainerManagerOffer: String?
    let trainers: [InitiatorCollab]?
    let sessionTrainersList: [InitiatorCollab]?
    let persistanceFailureStatus: Bool?
    let operationRequest: JSONNull?
    let present: Bool?
    let instantSessionEvaluation, instantTrainerEvaluation, instantParticipantEvaluation, delayedParticipantEvaluation: JSONNull?
    let delayedParticipantSkillsEvaluation: JSONNull?
    let sessionTrainingOrganizations: [JSONAny]?
    let sessionStartDate, sessionEndDate: Int?
    let sessionLabel: String?

    
}

// MARK: - Comment
struct Comment: Codable {
    let code: String?
    let commenter: Initiator?
    let text: String?
    let creationDate: Date?
}

// MARK: - Initiator
struct InitiatorCollab: Codable {
    let id, firstName, lastName, registrationNumber: String?
    let profilePicture, email: String?
    let affectation: AffectationCollab?
}

// MARK: - Affectation
struct AffectationCollab: Codable {
    let affectedPosition, affectedOrganizationalEntity: AffectedCollab?
}

// MARK: - Affected
struct AffectedCollab: Codable {
    let id, code, label: String?
}
