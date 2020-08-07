

import Foundation



// MARK: - ResponseFormation
struct ResponseFormation: Codable {
    let content: [FormationEntity]
    let last: Bool
    let totalElements, totalPages: Int?
    let first: Bool?
//    let sort: String?
    let numberOfElements, size, number: Int?
}



// MARK: - Content
struct FormationEntity: Codable {
    let id, code, label, picture: String?
    let theme, creationDate: String?
    let initiator: Initiator?
    let trainer: [Trainer]?
    let duration: Int?
    let unit: String?
    let numberParticipants: Int?
    let trainingOrganization: [String]?
    let trainingManager: Initiator?
//    let average: JSONNull?
    let status : String?
    
}



// MARK: - Initiator
struct Initiator: Codable {
    let id, firstName, lastName, registrationNumber: String
    let profilePicture, email: String
//    let affectation: Affectation
}



// MARK: - Affectation
struct Affectation: Codable {
    let affectedPosition, affectedOrganizationalEntity: Affected
}



// MARK: - Affected
struct Affected: Codable {
    let id, code, label: String
}

// MARK: - Trainer
struct Trainer: Codable {
    let id, firstName, lastName, registrationNumber: String
    let profilePicture, email: String?
    let affectation: String?
    let phone: String?
    let skills: [String]
//    let average: JSONNull
}
