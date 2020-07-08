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
    let id, code, campaignCode, label: String
    let startDate, endDate: String
    let participants: [String]
    let ratingScale: String
    let finalNote: JSONNull?
    let evaluatedRegistrationNumber: String
}


