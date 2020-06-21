//
//  MobiliteCollaborateurDetailsInteractor.swift
//  MakremAccretio
//
//  Created by Makrem on 3/3/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit
import Alamofire

protocol MobiliteCollaborateurDetailsBusinessLogic {
    func fetchFromLocalDataStore(with request: MobiliteCollaborateurDetailsModels.FetchFromLocalDataStore.Request)
    func fetchFromRemoteDataStore(with request: MobiliteCollaborateurDetailsModels.FetchFromRemoteDataStore.Request)
    func trackAnalytics(with request: MobiliteCollaborateurDetailsModels.TrackAnalytics.Request)
    func performMobiliteCollaborateurDetails(with request: MobiliteCollaborateurDetailsModels.PerformMobiliteCollaborateurDetails.Request)
    func getCodeCvCollaborator(token: String, codeOffer:String)
//    func postulerOffre(token : String)
    func postulerMobilite(fileUrl: URL)
}

protocol MobiliteCollaborateurDetailsDataStore {
    var exampleVariable: String? { get set }
}

class MobiliteCollaborateurDetailsInteractor: MobiliteCollaborateurDetailsBusinessLogic, MobiliteCollaborateurDetailsDataStore {
   
    

    // MARK: - Properties

    typealias Models = MobiliteCollaborateurDetailsModels

    lazy var worker = MobiliteCollaborateurDetailsWorker()
    var presenter: MobiliteCollaborateurDetailsPresentationLogic?

    var exampleVariable: String?

    // MARK: - Use Case - Fetch From Local DataStore

    func fetchFromLocalDataStore(with request: MobiliteCollaborateurDetailsModels.FetchFromLocalDataStore.Request) {
        let response = Models.FetchFromLocalDataStore.Response()
        presenter?.presentFetchFromLocalDataStore(with: response)
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    func fetchFromRemoteDataStore(with request: MobiliteCollaborateurDetailsModels.FetchFromRemoteDataStore.Request) {
        // fetch something from backend and return the values here
        // <#Network Worker Instance#>.fetchFromRemoteDataStore(completion: { [weak self] code in
        //     let response = Models.FetchFromRemoteDataStore.Response(exampleVariable: code)
        //     self?.presenter?.presentFetchFromRemoteDataStore(with: response)
        // })
    }

    // MARK: - Use Case - Track Analytics

    func trackAnalytics(with request: MobiliteCollaborateurDetailsModels.TrackAnalytics.Request) {
        // call analytics library/wrapper here to track analytics
        // <#Analytics Worker Instance#>.trackAnalytics(event: request.event)

        let response = Models.TrackAnalytics.Response()
        presenter?.presentTrackAnalytics(with: response)
    }

    // MARK: - Use Case - MobiliteCollaborateurDetails

    func performMobiliteCollaborateurDetails(with request: MobiliteCollaborateurDetailsModels.PerformMobiliteCollaborateurDetails.Request) {
        let error = worker.validate(exampleVariable: request.exampleVariable)

        if let error = error {
            let response = Models.PerformMobiliteCollaborateurDetails.Response(error: error)
            presenter?.presentPerformMobiliteCollaborateurDetails(with: response)
            return
        }

        // <#Network Worker Instance#>.performMobiliteCollaborateurDetails(completion: { [weak self, weak request] isSuccessful, error in
        //     self?.completion(request?.exampleVariable, isSuccessful, error)
        // })
    }

    private func completion(_ exampleVariable: String?, _ isSuccessful: Bool, _ error: Models.MobiliteCollaborateurDetailsError?) {
        if isSuccessful {
            // do something on success
            let goodExample = exampleVariable ?? ""
            self.exampleVariable = goodExample
        }

        let response = Models.PerformMobiliteCollaborateurDetails.Response(error: error)
        presenter?.presentPerformMobiliteCollaborateurDetails(with: response)
    }
    
    func getCodeCvCollaborator(token: String, codeOffer : String){
          worker = MobiliteCollaborateurDetailsWorker()
          worker.getCodeCvCollaborator(token: token).then(){
              codeCV in
            print(codeCV.code!)
            print("in Interactor ! list post")
                self.worker.getListOffrePostule(token: token, codeCV: codeCV.code!).then(){
                    listPosts in
                   
                    if((listPosts.content?.map{$0.codeRecruitmentOffer}.contains(codeOffer))!) {
                        self.presenter?.hidePostuler(hide: true)
                    }
                    else {
                        self.presenter?.hidePostuler(hide: false)
                    }
                }
            
          }
      }
    
    
//    func postulerOffre(token : String){
//        worker = MobiliteCollaborateurDetailsWorker()
//        worker.upload().then(){
//            uploadFile in
//            worker.postuler(token:token).then(){
//                postuler in
//
//            }
//        }
//    }
    
    func postulerMobilite(fileUrl: URL) {
           print(fileUrl)
                  let filename = fileUrl.lastPathComponent
                  let splitName = filename.split(separator: ".")
                  let filetype = String(describing: splitName.last)
                  var bodyData = Data()
                  var fileData: Data?
                  do {
                       fileData = try Data(contentsOf: fileUrl, options: [])
                      //bodyData.append(fileData)
                  } catch {
                      // can't load image data
                      print(error)
                  }
           worker = MobiliteCollaborateurDetailsWorker()
           let multipart = MultipartFormData()
                  print(filename)
                  
                  multipart.append(fileData ?? Data(), withName: "files", fileName: "0", mimeType: "image/png")
        let jsonObject : NSMutableDictionary? = NSMutableDictionary()
               let properties : NSMutableDictionary? = NSMutableDictionary()
               let filesToAddProperties : NSMutableDictionary? = NSMutableDictionary()
               let Prop : NSMutableDictionary? = NSMutableDictionary()
               filesToAddProperties?.setValue(filename, forKey: "fileName")
               filesToAddProperties?.setValue(["recruitment"], forKey: "modules")
               Prop?.setValue(filesToAddProperties, forKey: "0")
               properties?.setValue(Prop, forKey: "filesToAddProperties")
               jsonObject?.setValue(properties, forKey: "properties")
               print(jsonObject!)
               let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject!, options: .prettyPrinted)
               let jsonString = String(data: jsonData!, encoding: .utf8)
               
               multipart.append(jsonData!, withName: "properties", fileName: "blob", mimeType: "application/json")
         
        worker.uploadFile(multipartFormData: multipart).then {response in
                      
                      self.worker.postuler(attachedFile: [ response.add?.success?["0"] ?? ""])
                          .then { response in
                              print(response.response?.statusCode)
                            print("************************************************ upload interactor !")
                            print(response.response)
                                  if response.response?.statusCode == 400 {
                                  let dataerreur = try JSONDecoder().decode([ErreurAbsence].self, from: response.data!)
                                  self.presenter?.presentErreurAdd(response: dataerreur)
                              }
                                  else if response.response?.statusCode == 201  {
                                  let responsedata = try JSONDecoder().decode(Content.self, from: response.data!)
                                   self.presenter?.presentAdd(response: responsedata)
                              }
                              else {
                                  return
                              }
                      }
                      .catch { error in
                          self.presenter?.presentError(response: error)
                      }
                  }
                  .catch{ uploadError in
                      print(uploadError)
                  }
       }
    
    
    
    
    
}
