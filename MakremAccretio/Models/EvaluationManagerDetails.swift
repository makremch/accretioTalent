//
//  EvaluationManagerDetails.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/23/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation

// MARK: - EvaluationManagerDetailsResponse
struct EvaluationManagerDetailsResponse: Codable {
    let id, codeCampaign: String?
    let advancement: Int?
    let evaluated, evaluators: [String]?
    let cardsInprogressStatusNumber, cardsValidStatusNumber, cardsClosedStatusNumber: Int?
    let evaluationConfigurations, settingsConfigurations: [String]?
}

// MARK: - StepsDetailsResponseElement
struct StepsDetailsResponseElement: Codable {
    let stepName: String?
    let count: Int?
}

typealias StepsDetailsResponse = [StepsDetailsResponseElement]
