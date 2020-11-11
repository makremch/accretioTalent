//
//  CompetenceCollab.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 6/2/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation



// MARK: - CompetenseResponse
struct CompetenseResponse: Codable {
    var content: [CompetenceCollab]?
    let totalPages, totalElements: Int?
    let last: Bool?
    let numberOfElements: Int?
    let first: Bool?
    let sort: JSONNull?
    let size, number: Int?
}

// MARK: - Content
struct CompetenceCollab: Codable {
    let employees, labelComponent: String?
    let codeComponent, firstName, lastName, affectedJob: String?
    let affectedPosition, profilePicture: String?
    let affectationSkillByClassificationDTOList: [AffectationSkillByClassificationDTOList]
}

// MARK: - AffectationSkillByClassificationDTOList
struct AffectationSkillByClassificationDTOList: Codable {
    let skillsLevelClassificationDTO: SkillsLevelClassificationDTO?
    let skills: [Skill]?
}

// MARK: - Skill
struct Skill: Codable {
    let codeSkill, skillLevel: String?
    let skillAcquired, skillImportance, inheritedFlag, coefficient: String?
    let operation: String?
    let acquisitionDate: Int?
    let source: String?
    let skillRequiredLevel: String?
    let historic: [Historic]?
}

// MARK: - Historic
struct Historic: Codable {
    let level: String?
    let source: String?
    let acquisitionDate: Int?
}

// MARK: - SkillsLevelClassificationDTO
struct SkillsLevelClassificationDTO: Codable {
    let classificationDTO, crSkillsLevels: ClassificationDto?
}

// MARK: - ClassificationDto
struct ClassificationDto: Codable {
    
    
    let id, code, value, level: String?
    let levels: [Level]?
}

// MARK: - Level
struct Level: Codable {
    let id: String?
    let code: String?
    let value: Int?
    let label: String?
}
