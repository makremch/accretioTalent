//
//  AddCompetence.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 18/11/2020.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation

// MARK: - ResponseAdding
struct AddCompetenceRequest: Codable {
    let code, codeSkill, skillLevel, source: String?
    let acquisitionDate: Int?
    let codeComponent: String?
    let historicEmployeeAffectationSkills: JSONNull?
}


// MARK: - ResponseAddingCompetence
struct ResponseAddingCompetence: Codable {
    let employees, labelComponent: JSONNull?
    let codeComponent, firstName, lastName, affectedJob: String?
    let affectedPosition, profilePicture: String?
    let affectationSkillByClassificationDTOList: [AffectationSkillByClassificationDTOList]?
}



