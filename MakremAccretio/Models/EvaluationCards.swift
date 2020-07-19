//
//  EvaluationCards.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/11/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation

// MARK: - Evaluation Cards Response
struct EvaluationCardsResponse: Codable {
    let id: JSONNull?
    let code: String?
    let weight: Int?
    let axisComments: JSONNull?
    let communTargetsCard: [CommunTargetsCard]?
    let averageAxis: JSONNull?
}

// MARK: - CommunTargetsCard
struct CommunTargetsCard: Codable {
    let id: JSONNull?
    let code, label, communTargetsCardDescription: String?
    let weight: Int?
    let communTargetCardComments, averageCommunTargets: JSONNull?
    let indicatorsCard: [IndicatorsCard]?

    enum CodingKeys: String, CodingKey {
        case id, code, label
        case communTargetsCardDescription = "description"
        case weight, communTargetCardComments, averageCommunTargets, indicatorsCard
    }
}

// MARK: - IndicatorsCard
struct IndicatorsCard: Codable {
    let indicatorcode: String?
    let weight: Int?
    let id: JSONNull?
    let label, targetValue: String?
    let indicatorsComments, averageIndicators: JSONNull?
}

