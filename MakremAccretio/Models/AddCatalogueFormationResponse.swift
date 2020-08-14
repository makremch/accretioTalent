//
//  AddCatalogueFormation.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 6/28/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation



// MARK: - TrainingResponseModel
struct TrainingResponseModel: Codable {
    internal init() {
           self.id = ""
           self.code = ""
           self.creationDate = ""
           self.initiator = InitiatorSession()
           self.initiatorType = ""
           self.trainingOfferCode = nil
           self.targetEmployees = []
           self.importance = ""
           self.priority = false
           self.limitDate = ""
           self.trainingRequestModelDescription = ""
           self.status = ""
           self.currentStep = nil
           self.codeModel = nil
           self.trainingPlanCode = nil
           self.processID = nil
           self.isOutOfCatalog = false
           self.label = ""
           self.workflowHistory = nil
       }
    
    let id, code, creationDate: String
    let initiator: InitiatorSession
    let initiatorType: String
    let trainingOfferCode: JSONNull?
    let targetEmployees: [InitiatorSession]
    let importance: String
    let priority: Bool
    let limitDate, trainingRequestModelDescription, status: String
    let currentStep, codeModel, trainingPlanCode, processID: JSONNull?
    let isOutOfCatalog: Bool
    let label: String
    let workflowHistory: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, code, creationDate, initiator, initiatorType, trainingOfferCode, targetEmployees, importance, priority, limitDate
        case trainingRequestModelDescription = "description"
        case status, currentStep, codeModel, trainingPlanCode
        case processID = "processId"
        case isOutOfCatalog, label, workflowHistory
    }
}

// MARK: TrainingRequestModel convenience initializers and mutators

extension TrainingResponseModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TrainingResponseModel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

  

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: Initiator convenience initializers and mutators

extension Initiator {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Initiator.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

   

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}



// MARK: Affectation convenience initializers and mutators

extension Affectation {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Affectation.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        affectedPosition: Affected? = nil,
        affectedOrganizationalEntity: Affected? = nil
    ) -> Affectation {
        return Affectation(
            affectedPosition: affectedPosition ?? self.affectedPosition,
            affectedOrganizationalEntity: affectedOrganizationalEntity ?? self.affectedOrganizationalEntity
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}



// MARK: Affected convenience initializers and mutators

extension Affected {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Affected.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String? = nil,
        code: String? = nil,
        label: String? = nil
    ) -> Affected {
        return Affected(
            id: id ?? self.id,
            code: code ?? self.code,
            label: label ?? self.label
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
