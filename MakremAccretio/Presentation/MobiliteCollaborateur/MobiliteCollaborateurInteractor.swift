//
//  MobiliteCollaborateurInteractor.swift
//  MakremAccretio
//
//  Created by Makrem on 3/2/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol MobiliteCollaborateurBusinessLogic {
    func fetchFromLocalDataStore(with request: MobiliteCollaborateurModels.FetchFromLocalDataStore.Request)
    func fetchFromRemoteDataStore(with request: MobiliteCollaborateurModels.FetchFromRemoteDataStore.Request)
    func trackAnalytics(with request: MobiliteCollaborateurModels.TrackAnalytics.Request)
    func performMobiliteCollaborateur(with request: MobiliteCollaborateurModels.PerformMobiliteCollaborateur.Request)
    func getListMobilityCollaborator(token : String )
    
}

protocol MobiliteCollaborateurDataStore {
    var exampleVariable: String? { get set }
}

class MobiliteCollaborateurInteractor: MobiliteCollaborateurBusinessLogic, MobiliteCollaborateurDataStore {
    
    // MARK: - Properties
    
    typealias Models = MobiliteCollaborateurModels
    
    lazy var worker = MobiliteCollaborateurWorker()
    var presenter: MobiliteCollaborateurPresentationLogic?
    
    var exampleVariable: String?
    
    // MARK: - Use Case - Fetch From Local DataStore
    
    func fetchFromLocalDataStore(with request: MobiliteCollaborateurModels.FetchFromLocalDataStore.Request) {
        let response = Models.FetchFromLocalDataStore.Response()
        presenter?.presentFetchFromLocalDataStore(with: response)
    }
    
    // MARK: - Use Case - Fetch From Remote DataStore
    
    func fetchFromRemoteDataStore(with request: MobiliteCollaborateurModels.FetchFromRemoteDataStore.Request) {
        // fetch something from backend and return the values here
        // <#Network Worker Instance#>.fetchFromRemoteDataStore(completion: { [weak self] code in
        //     let response = Models.FetchFromRemoteDataStore.Response(exampleVariable: code)
        //     self?.presenter?.presentFetchFromRemoteDataStore(with: response)
        // })
    }
    
    // MARK: - Use Case - Track Analytics
    
    func trackAnalytics(with request: MobiliteCollaborateurModels.TrackAnalytics.Request) {
        // call analytics library/wrapper here to track analytics
        // <#Analytics Worker Instance#>.trackAnalytics(event: request.event)
        
        let response = Models.TrackAnalytics.Response()
        presenter?.presentTrackAnalytics(with: response)
    }
    
    // MARK: - Use Case - MobiliteCollaborateur
    
    func performMobiliteCollaborateur(with request: MobiliteCollaborateurModels.PerformMobiliteCollaborateur.Request) {
        let error = worker.validate(exampleVariable: request.exampleVariable)
        
        if let error = error {
            let response = Models.PerformMobiliteCollaborateur.Response(error: error)
            presenter?.presentPerformMobiliteCollaborateur(with: response)
            return
        }
        
        // <#Network Worker Instance#>.performMobiliteCollaborateur(completion: { [weak self, weak request] isSuccessful, error in
        //     self?.completion(request?.exampleVariable, isSuccessful, error)
        // })
    }
    
    private func completion(_ exampleVariable: String?, _ isSuccessful: Bool, _ error: Models.MobiliteCollaborateurError?) {
        if isSuccessful {
            // do something on success
            let goodExample = exampleVariable ?? ""
            self.exampleVariable = goodExample
        }
        
        let response = Models.PerformMobiliteCollaborateur.Response(error: error)
        presenter?.presentPerformMobiliteCollaborateur(with: response)
    }
    
    
    
    
    func getListMobilityCollaborator(token : String ) {
        worker = MobiliteCollaborateurWorker()
        worker.getListMobilityCollaborator(token: token).then() {
            demandeCollaborateurResponse in
            print("in Interactor getlistMobility collabb : *************************** count")
            print(demandeCollaborateurResponse.content.count)
            print("***********************************************************")
            self.presenter?.showMobilitiesCollaborator(responses: demandeCollaborateurResponse)
        }.catch {error in
            print(error)
            //  self.presenter?.presentSignInError(error: error)
        }
    }
    
  
    
    
}
