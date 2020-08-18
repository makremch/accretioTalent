//
//  FormationCollaborateurDetail.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 8/14/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation


// MARK: - FormationCatalogueDetails
struct FormationCatalogueDetails: Codable {
    let documentsList: [JSONAny]?
    let id, code, label, picture: String?
    let theme: String?
    let goals, program: Goals?
    let duration: Int?
    let unit, target, trainingType: String?
    let trainingOrganization: [TrainingOrganization]?
    let trainer: [Trainer]?
    let place: String?
    let capacity: Int?
    let certification: Bool?
    let costs: Int?
    let publicationFlag, publishedForEmployees, publishedForManagers: Bool?
    let targetSkills: [TargetSkill]?
    let creationDate: String?
    let initiator: Initiator?
    let codeModel: JSONNull?
    let trainingManager: Initiator?
    let average: Int?
    let documentsIDSList: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case documentsList, id, code, label, picture, theme, goals, program, duration, unit, target, trainingType, trainingOrganization, trainer, place, capacity, certification, costs, publicationFlag, publishedForEmployees, publishedForManagers, targetSkills, creationDate, initiator, codeModel, trainingManager, average
        case documentsIDSList = "documentsIdsList"
    }
}

// MARK: - Goals
struct Goals: Codable {
    let textArea, attachementFile: String?
}


// MARK: - TargetSkill
struct TargetSkill: Codable {
    let codeSkill, levelSkill: String?
}


// MARK: - TrainingOrganization
struct TrainingOrganization: Codable {
    let trainingOrganisation: String?
    let trainingOrganisationAverage: Int?
}
