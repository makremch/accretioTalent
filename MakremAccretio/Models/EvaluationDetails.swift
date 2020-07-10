//
//  EvaluationDetails.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/10/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation

// MARK: - EvaluationDetailsResponse
struct EvaluationDetailsResponse: Codable {
    let id, code: JSONNull?
    let evaluated : Evaluat?
    let evaluator : Evaluat?
    let steps: JSONNull?
    let startDateCampaign, endDateCampaign: String?
    let objectifsNumber, advancement, seniority: Int?
    let campaignStatus: String?
    let averageIndividualTarget, averageCommunTarget: JSONNull?
    let taskID, processID: String?
    let finalNote: JSONNull?
    let previousTargets, communTargets, training, profesionnalProject: Bool?
    let nextTargets: Bool?
    let evaluationStatus: String?
    let skillsFlag, locked: Bool?
    let startingDate, endingDate: Int?
    let currentStep: CurrentStep?

    enum CodingKeys: String, CodingKey {
        case id, code, evaluated, evaluator, steps, startDateCampaign, endDateCampaign, objectifsNumber, advancement, seniority, campaignStatus, averageIndividualTarget, averageCommunTarget
        case taskID = "taskId"
        case processID = "processId"
        case finalNote, previousTargets, communTargets, training, profesionnalProject, nextTargets, evaluationStatus, skillsFlag, locked, startingDate, endingDate, currentStep
    }
}

// MARK: - CurrentStep
struct CurrentStep: Codable {
    let taskID, name, startDate: String
    let endDate, decision, comment: JSONNull?
    let assignedTo: String
    let executedBy: JSONNull?
    let privilege: String
    let decisionRequired: Bool

    enum CodingKeys: String, CodingKey {
        case taskID = "taskId"
        case name, startDate, endDate, decision, comment, assignedTo, executedBy, privilege, decisionRequired
    }
}

// MARK: - Evaluat
struct Evaluat: Codable {
    let id, firstName, lastName: String
    let employeeType: EmployeeType
    let registrationNumber: String
    let affectation: Affectation
    let hiringExit: HiringExit
    let contract: Contract
    let profilePicture, userAccount: String
    let status: Status
    let seniorityCompanyPeriod, email: String
}

// MARK: - Contract
struct Contract: Codable {
    let contractType: String
}

// MARK: - HiringExit
struct HiringExit: Codable {
    let hiringEffectiveDate: String
}

