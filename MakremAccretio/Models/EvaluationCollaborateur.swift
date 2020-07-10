//
//  EvaluationCollaborateur.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/5/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation


// MARK: - EvaluationResponse
struct EvaluationResponse: Codable {
    let content: [EvaluationCollab]
    let totalElements: Int
    let last: Bool
    let totalPages: Int
    let sort: JSONNull?
    let first: Bool
    let numberOfElements, size, number: Int
}

// MARK: - Content
struct EvaluationCollab: Codable {
    let id, code, label, contentDescription: String
    let ratingScale: String
    let startDate, endDate: String
    let status: String
    let evaluationPeriod, targetsSettingPeriod: Bool
    let steps: JSONNull?
    let participants: [String]
    let workflowVersion: Int
    let decisionRequired: Bool

    enum CodingKeys: String, CodingKey {
        case id, code, label
        case contentDescription = "description"
        case ratingScale, startDate, endDate, status, evaluationPeriod, targetsSettingPeriod, steps, participants, workflowVersion, decisionRequired
    }
}
