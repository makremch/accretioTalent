//
//  MobiliteInteractor.swift
//  MakremAccretio
//
//  Created by Makrem on 2/20/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit
import Promise
protocol MobiliteBusinessLogic {
    func fetchFromLocalDataStore(with request: MobiliteModels.FetchFromLocalDataStore.Request)
    func fetchFromRemoteDataStore(with request: MobiliteModels.FetchFromRemoteDataStore.Request)
    func trackAnalytics(with request: MobiliteModels.TrackAnalytics.Request)
    func performMobilite(with request: MobiliteModels.PerformMobilite.Request)
    func getListMobility(token : String )
    func getListMobilityForValidation(token : String)
}

protocol MobiliteDataStore {
    var exampleVariable: String? { get set }
}

class MobiliteInteractor: MobiliteBusinessLogic, MobiliteDataStore {
    
    
    
    
    // MARK: - Properties
    
    typealias Models = MobiliteModels
    
    lazy var worker = MobiliteWorker()
    var presenter: MobilitePresentationLogic?
    
    var exampleVariable: String?
    
    // MARK: - Use Case - Fetch From Local DataStore
    
    func fetchFromLocalDataStore(with request: MobiliteModels.FetchFromLocalDataStore.Request) {
        let response = Models.FetchFromLocalDataStore.Response()
        presenter?.presentFetchFromLocalDataStore(with: response)
    }
    
    // MARK: - Use Case - Fetch From Remote DataStore
    
    func fetchFromRemoteDataStore(with request: MobiliteModels.FetchFromRemoteDataStore.Request) {
        // fetch something from backend and return the values here
        // <#Network Worker Instance#>.fetchFromRemoteDataStore(completion: { [weak self] code in
        //     let response = Models.FetchFromRemoteDataStore.Response(exampleVariable: code)
        //     self?.presenter?.presentFetchFromRemoteDataStore(with: response)
        // })
    }
    
    // MARK: - Use Case - Track Analytics
    
    func trackAnalytics(with request: MobiliteModels.TrackAnalytics.Request) {
        // call analytics library/wrapper here to track analytics
        // <#Analytics Worker Instance#>.trackAnalytics(event: request.event)
        
        let response = Models.TrackAnalytics.Response()
        presenter?.presentTrackAnalytics(with: response)
    }
    
    // MARK: - Use Case - Mobilite
    
    func performMobilite(with request: MobiliteModels.PerformMobilite.Request) {
        let error = worker.validate(exampleVariable: request.exampleVariable)
        
        if let error = error {
            let response = Models.PerformMobilite.Response(error: error)
            presenter?.presentPerformMobilite(with: response)
            return
        }
        
        // <#Network Worker Instance#>.performMobilite(completion: { [weak self, weak request] isSuccessful, error in
        //     self?.completion(request?.exampleVariable, isSuccessful, error)
        // })
    }
    
    private func completion(_ exampleVariable: String?, _ isSuccessful: Bool, _ error: Models.MobiliteError?) {
        if isSuccessful {
            // do something on success
            let goodExample = exampleVariable ?? ""
            self.exampleVariable = goodExample
        }
        
        let response = Models.PerformMobilite.Response(error: error)
        presenter?.presentPerformMobilite(with: response)
    }
    
    
    
    
    
    func getListMobility(token : String ) {
        worker = MobiliteWorker()
        let ud = UserDefaults.standard
        let roles = ud.stringArray(forKey: "listRoles") ?? [String]()
        let isManager = roles.contains("ROLE_MANAGER")
        worker.getListMobility(token: token , isManager: isManager).then() {
            demandeResponse in
            print("in Interactor getlistMobility : ***************************")
            print(demandeResponse)
            print("***********************************************************")
            self.presenter?.showMobilities(responses: demandeResponse, choix: 0)
        }.catch {error in
            print(error)
//            self.presenter?.presentSignInError(error: error)
        }
    }
    
    func getListMobilityForValidation(token : String){
        worker = MobiliteWorker()
        worker.getListMobilityForValidation(token: token).then(){
            demandeResponse in
            print("in interactor for validation function ! ")
            print("_______________________")
            print(demandeResponse)
            self.presenter?.showMobilitiesForValidation(responses : demandeResponse)
        }.catch {
            error in
            print(error)
        }
        
    }
    
}

