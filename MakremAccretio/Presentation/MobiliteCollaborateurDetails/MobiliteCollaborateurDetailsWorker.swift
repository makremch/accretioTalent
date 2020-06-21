//
//  MobiliteCollaborateurDetailsWorker.swift
//  MakremAccretio
//
//  Created by Makrem on 3/3/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit
import Promise
import Alamofire

class MobiliteCollaborateurDetailsWorker {

    // MARK: - Properties

    typealias Models = MobiliteCollaborateurDetailsModels

    // MARK: - Methods

    // MARK: Screen Specific Validation

    func validate(exampleVariable: String?) -> Models.MobiliteCollaborateurDetailsError? {
        var error: Models.MobiliteCollaborateurDetailsError?

        if exampleVariable?.isEmpty == false {
            error = nil
        } else {
            error = Models.MobiliteCollaborateurDetailsError(type: .emptyExampleVariable)
        }

        return error
    }
    
     func getCodeCvCollaborator(token : String) -> Promise<CodeCv> {
           return MobiliteAPI.getCodeCV(token: token)
       }
    
    func getListOffrePostule(token:String,codeCV:String) -> Promise<ResponseVerif> {
        return MobiliteAPI.verifPostulerOffreByCollaborator(token:token,codeCV: codeCV)
    }
    func postuler(attachedFile: [String?] = []) -> Promise<DataResponse<Data?, AFError>> {
        return UserAPIClient.postuler(attachedFile: attachedFile)
    }
    
    func uploadFile(multipartFormData: MultipartFormData) -> Promise<FileResponses> {
        return UserAPIClient.uploadFile(fileMultipart: multipartFormData)
    }
//    func upload(token : String, fileName: String) -> Promise<[String]>{
//        return MobiliteAPI.uploadFile(filename: fileName, token: token)
//    }
    
//    func postuler(){
//        
//    }
}
