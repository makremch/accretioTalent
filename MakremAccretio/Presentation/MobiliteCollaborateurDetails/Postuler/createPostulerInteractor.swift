//
//  createPostulerInteractor.swift
//  MakremAccretio
//
//  Created by Makrem on 3/30/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol createPostulerBusinessLogic {
    func fetchFromLocalDataStore(with request: createPostulerModels.FetchFromLocalDataStore.Request)
    func fetchFromRemoteDataStore(with request: createPostulerModels.FetchFromRemoteDataStore.Request)
    func trackAnalytics(with request: createPostulerModels.TrackAnalytics.Request)
    func performcreatePostuler(with request: createPostulerModels.PerformcreatePostuler.Request)
  
}

protocol createPostulerDataStore {
    var exampleVariable: String? { get set }
}

class createPostulerInteractor: createPostulerBusinessLogic, createPostulerDataStore {

    // MARK: - Properties

    typealias Models = createPostulerModels

    lazy var worker = createPostulerWorker()
    var presenter: createPostulerPresentationLogic?

    var exampleVariable: String?

    // MARK: - Use Case - Fetch From Local DataStore

    func fetchFromLocalDataStore(with request: createPostulerModels.FetchFromLocalDataStore.Request) {
        let response = Models.FetchFromLocalDataStore.Response()
        presenter?.presentFetchFromLocalDataStore(with: response)
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    func fetchFromRemoteDataStore(with request: createPostulerModels.FetchFromRemoteDataStore.Request) {
        // fetch something from backend and return the values here
        // <#Network Worker Instance#>.fetchFromRemoteDataStore(completion: { [weak self] code in
        //     let response = Models.FetchFromRemoteDataStore.Response(exampleVariable: code)
        //     self?.presenter?.presentFetchFromRemoteDataStore(with: response)
        // })
    }

    // MARK: - Use Case - Track Analytics

    func trackAnalytics(with request: createPostulerModels.TrackAnalytics.Request) {
        // call analytics library/wrapper here to track analytics
        // <#Analytics Worker Instance#>.trackAnalytics(event: request.event)

        let response = Models.TrackAnalytics.Response()
        presenter?.presentTrackAnalytics(with: response)
    }

    // MARK: - Use Case - createPostuler

    func performcreatePostuler(with request: createPostulerModels.PerformcreatePostuler.Request) {
        let error = worker.validate(exampleVariable: request.exampleVariable)

        if let error = error {
            let response = Models.PerformcreatePostuler.Response(error: error)
            presenter?.presentPerformcreatePostuler(with: response)
            return
        }

        // <#Network Worker Instance#>.performcreatePostuler(completion: { [weak self, weak request] isSuccessful, error in
        //     self?.completion(request?.exampleVariable, isSuccessful, error)
        // })
    }

    private func completion(_ exampleVariable: String?, _ isSuccessful: Bool, _ error: Models.createPostulerError?) {
        if isSuccessful {
            // do something on success
            let goodExample = exampleVariable ?? ""
            self.exampleVariable = goodExample
        }

        let response = Models.PerformcreatePostuler.Response(error: error)
        presenter?.presentPerformcreatePostuler(with: response)
    }
    
    
    
    
    
//
//
//        func uploadFile(fileUrl: URL, body: String) {
//            let filename = fileUrl.lastPathComponent
//            let splitName = filename.split(separator: ".")
//            let filetype = String(describing: splitName.last)
//            var bodyData = Data()
//
//            do {
//                let fileData = try Data(contentsOf: fileUrl, options: [])
//                bodyData.append(fileData)
//            } catch {
//                // can't load image data
//                print(error)
//            }
//            worker = createPostulerWorker()
//            let multipart = MultipartFormData()
//            multipart.append(bodyData, withName: "files", fileName: filename, mimeType: MimeTypes.mimeType(forExtension: filetype))
//    //        /documentsmanagement/api/create/recruitment?isPublic=false" upload file :
//            worker?.upload(multipartFormData: multipart).then {response in
//
//    //            candidature :
//    //            recruitment/api/candidatures + body objet candidature
//                self.worker?.createDocumentPost(documentCode: response[0], fileName: filename, body: body, taggedEmployees: taggedEmployees,timelines: timelines ).then { postResponse in
//                    self.presenter?.presentCreatePostSuccess(post: postResponse)
//                }.catch {postError in
//                    self.presenter?.presentCreatePostError(error: postError)
//                }
//            }.catch {uploadError in
//                self.presenter?.presentUploadError(error: uploadError)
//            }
//        }
//
//
//        func uploadText(body: String) {
//            worker = CreatePostWorker()
//            worker?.createTextPost(body: body, taggedEmployees: taggedEmployees, timelines: timelines).then { post in
//                self.presenter?.presentCreatePostSuccess(post: post)
//            }.catch { error in
//                self.presenter?.presentCreatePostError(error: error)
//            }
//        }
    
    
    
    
}
