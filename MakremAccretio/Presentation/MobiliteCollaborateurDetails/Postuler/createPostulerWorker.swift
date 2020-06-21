//
//  createPostulerWorker.swift
//  MakremAccretio
//
//  Created by Makrem on 3/30/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit
import Promise
import Alamofire

class createPostulerWorker {

    // MARK: - Properties

    typealias Models = createPostulerModels

    // MARK: - Methods

    // MARK: Screen Specific Validation

    func validate(exampleVariable: String?) -> Models.createPostulerError? {
        var error: Models.createPostulerError?

        if exampleVariable?.isEmpty == false {
            error = nil
        } else {
            error = Models.createPostulerError(type: .emptyExampleVariable)
        }

        return error
    }
    
    func postuler(attachedFile: [String?] = []) -> Promise<DataResponse<Data?, AFError>> {
        return UserAPIClient.postuler(attachedFile: attachedFile)
    }
//    func upload(multipartFormData: MultipartFormData) -> Promise<[String]> {
//        return TimelineAPIClient.uploadFile(fileMultipart: multipartFormData)
//    }
//    func createTextPost(body: String, taggedEmployees: [TagEmployee], timelines: [String]?) -> Promise<Post> {
//        return TimelineAPIClient.postText(body: body,taggedEmployees: taggedEmployees, timelines:timelines)
//    }
//    func createDocumentPost(documentCode: String, fileName: String, body: String, taggedEmployees: [TagEmployee], timelines: [String]?) -> Promise<Post> {
//        return TimelineAPIClient.postDocument(documentCode: documentCode, documentName: fileName, body: body,taggedEmployees: taggedEmployees, timelines:timelines)
//    }
//    
}
