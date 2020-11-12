//
//  CompetenceCollabForLabel.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 6/19/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation



// MARK: - CompetenseLabelResponseElement
struct CompetenseLabelResponseElement: Codable {
    let id, code, label, competenseLabelResponseDescription: String?
    let classification: String?
    let levels: [LevelLabel]?
//    let codeModel: String?
//    let version: Int?
//    let usedBy: [UsedBy]?

    
}

// MARK: - Level
struct LevelLabel: Codable {
    let id: String?
    let code, levelDescription: String?

   
}

// MARK: - UsedBy
struct UsedBy: Codable {
    let code: String?
    let collectionName: String?
    let microServiceName: String?
}




