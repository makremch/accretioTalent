//
//  EvaluatedManager.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 8/19/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation

// MARK: - Evaluated
struct EvaluatedResponse: Codable {
    let content: [EvaluatedElement]?
    let totalElements: Int?
    let last: Bool?
    let totalPages: Int?
    let first: Bool?
    let sort: JSONNull?
    let numberOfElements, size, number: Int?
}

// MARK: - Content
struct EvaluatedElement: Codable {
    let processID: Int?
    let evaluated: EvaluatedClass?
    let status, statusCard: String?
    let evaluators: [JSONAny]?
    let globalMark: Int?
    let advancement, currentStep, currentStepAssignee: JSONNull?
    let lockedCampaignFlag: Bool?

    enum CodingKeys: String, CodingKey {
        case processID = "processId"
        case evaluated, status, statusCard, evaluators, globalMark, advancement, currentStep, currentStepAssignee, lockedCampaignFlag
    }
}

// MARK: - EvaluatedClass
struct EvaluatedClass: Codable {
    let id, firstName, lastName: String?
    let employeeType: EmployeeType?
    let registrationNumber: String?
    let affectation: Affectation?
    let hiringExit: HiringExit?
    let contract: Contract?
    let profilePicture, userAccount: String?
    let status: Status?
    let seniorityCompanyPeriod, email: String?
}

