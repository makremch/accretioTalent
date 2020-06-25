//
//  ManagerCompetence.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 6/21/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation


// MARK: - CompetenseManager
struct CompetenseManagerResponse: Codable {
    let content: [Competences]?
    let totalPages, totalElements: Int?
    let last: Bool?
    let numberOfElements: Int?
    let first: Bool?
    let sort: Int?
    let size, number: Int?
}

// MARK: - Competence
struct Competences: Codable {
    let employees, labelComponent: String?
    let codeComponent, firstName, lastName, affectedJob: String?
    let affectedPosition: String?
    let profilePicture: String?
    let affectationSkillByClassificationDTOLists: [String]?
}
