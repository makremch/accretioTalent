//
//  LevelResponse.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 11/12/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation

// MARK: - LevelResponse
struct LevelResponse: Codable {
    let id, code, value, levelResponseDescription: String
    let levels: [Level]
    let flag: Bool
    let usedBy: [UsedBy]
    let codeModel, destination: JSONNull?
    let levelResponseDefault: Bool

    enum CodingKeys: String, CodingKey {
        case id, code, value
        case levelResponseDescription = "description"
        case levels, flag, usedBy, codeModel, destination
        case levelResponseDefault = "default"
    }
}




enum CollectionName: String, Codable {
    case crSkillsClassification = "CRSkillsClassification"
}

enum MicroServiceName: String, Codable {
    case dataAndTranslation = "data-and-translation"
}


