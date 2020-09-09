//
//  MobiliteCollaborateur.swift
//  MakremAccretio
//
//  Created by Makrem on 3/2/20.
//  Copyright © 2020 Makrem. All rights reserved.
//
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let content: [Content]?
    let last: Bool?
    let totalElements, totalPages: Int?
    let sort: JSONNull?
    let first: Bool?
    let numberOfElements, size, number: Int?
}

// MARK: - Content
struct Content: Codable {
    let documentsList: [DocumentsList]?
    let id, offerCode, publishedOfferCode, publicationMode: String?
    let manualPublicationEnabled: Bool?
    let programmedPublicationStartDate: String?
    let programmedPublicationEndDate: String?
    let publishedLabelOffer, publishedMissionOffer, publishedRequiredProfilOffer: String?
    let publishedLocalisationOffer, publishedContractOffer: [String]?
    let publishedDocumentsOffer: [String]?
    let publishedPictureOffer: String?
    let initiator: Initiator?
//    let type: String?
//    let configuration: Configuration?
}

// MARK: - Configuration
struct Configuration: Codable {
    let publication, candidature: [Candidature]?
    let candidate: [Candidature]?
}

// MARK: - Candidature
struct Candidature: Codable {
    let name: String?
    let candidatureRequired, showed: Bool?

    enum CodingKeys: String, CodingKey {
        case name
        case candidatureRequired = "required"
        case showed
    }
}

// MARK: - DocumentsList
struct DocumentsList: Codable {
    let documentID, name, path: String?
    let size: Int?
    let type, creationDate: String?
    let documentContent: JSONNull?

    enum CodingKeys: String, CodingKey {
        case documentID = "documentId"
        case name, path, size, type, creationDate, documentContent
    }
}


// MARK: - Status
struct Status: Codable {
    let id: JSONNull?
    let statusEffectiveDate, effectiveStatus: String?
}

struct ErreurAbsence: Codable {
    let validateField: String?
    let validationError: String?
}
struct FileResponses: Codable {
    var  add : FileAddResponse?
}

struct FileAddResponse: Codable {
    var error : [String : String]?
    var success :  [String : String]?
}
