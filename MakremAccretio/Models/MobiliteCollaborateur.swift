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
    let content: [Content]
    let totalElements: Int?
    let last: Bool?
    let totalPages: Int?
    let first: Bool?
    let numberOfElements, size, number: Int?
}



// MARK: - Content
struct Content: Codable {
    let documentsList: [DocumentsLists]?
    let codeOffer: String?
    let publishedOfferCode : String?
    let publishedStartDate: String?
    let publishedEndDate: String?
    let publishedStatusOffer: String?
    let publishedLabelOffer: String?
    let publishedMissionOffer : String?
    let publishedRequiredProfilOffer : String?
    let publishedLocalisationOffer: [String?]
    let publishedContractOffer: [String]?
    let publishedDocumentsOffer: [String]?
    let publishedPictureOffer: String?
}
//
//// MARK: - DocumentsList
struct DocumentsLists: Codable {
    let documentID, name, path: String?
    let size: Int?
    let type, creationDate: String?
    let documentContent: String?

}

//// MARK: - Initiator
//struct Initiator: Codable {
//    let id: String?
//    let firstName: String?
//    let lastName: String?
//    let employeeType: String?
//    let registrationNumber: String?
//    let profilePicture: String?
//    let email: String?
//    let status: Status?
//}

//
//// MARK: - EmployeeTypeClass
//struct EmployeeTypeClass: Codable {
//    let id: JSONNull?
//    let employeeType: String?
//    let typeEffectiveDate: String?
//}

//
//// MARK: - Status
//struct Status: Codable {
//    let id: JSONNull?
//    let statusEffectiveDate: String?
//    let effectiveStatus: String?
//}



enum PublishedContractOffer: String, Codable {
    case crtCdd = "CRT_CDD"
    case crtCdi = "CRT_CDI"
    case crtKarama = "CRT_KARAMA"
    case crtSivp = "CRT_SIVP"
    case crtCtt = "CRT_CTT"
    case crtAlternance = "CRT_alternance"
    case crtAlternancePro = "CRT_AlternancePro"
    case crtCUI = "CRT_CUI"
    case crtCAE = "CRT_CAE"
}

enum PublishedStatusOffer: String, Codable {
    case publised = "PUBLISED"
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
// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
