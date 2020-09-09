//
//  MobilitePresenter.swift
//  MakremAccretio
//
//  Created by Makrem on 2/20/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol MobilitePresentationLogic {
    func presentFetchFromLocalDataStore(with response: MobiliteModels.FetchFromLocalDataStore.Response)
    func presentFetchFromRemoteDataStore(with response: MobiliteModels.FetchFromRemoteDataStore.Response)
    func presentTrackAnalytics(with response: MobiliteModels.TrackAnalytics.Response)
    func presentPerformMobilite(with response: MobiliteModels.PerformMobilite.Response)
    func presentListView(inputArray:Array<Demande>)
    func showMobilities(responses: DemandeResponse, choix : Int)
    func showMobilitiesForValidation(responses : DemandeResponse)
    func showMobilitiesForValidationError()
}

class MobilitePresenter: MobilitePresentationLogic {
    func presentListView(inputArray: Array<Demande>) {
        
    }
    
    
    // MARK: - Properties
    
    typealias Models = MobiliteModels
    weak var mobiliteViewController: MobiliteDisplayLogic?
    
    // MARK: - Use Case - Fetch From Local DataStore
    
    func presentFetchFromLocalDataStore(with response: MobiliteModels.FetchFromLocalDataStore.Response) {
        let translation = "Some localized text."
        let viewModel = Models.FetchFromLocalDataStore.ViewModel(exampleTranslation: translation)
        mobiliteViewController?.displayFetchFromLocalDataStore(with: viewModel)
    }
    
    // MARK: - Use Case - Fetch From Remote DataStore
    
    func presentFetchFromRemoteDataStore(with response: MobiliteModels.FetchFromRemoteDataStore.Response) {
        let formattedExampleVariable = response.exampleVariable ?? ""
        let viewModel = Models.FetchFromRemoteDataStore.ViewModel(exampleVariable: formattedExampleVariable)
        mobiliteViewController?.displayFetchFromRemoteDataStore(with: viewModel)
    }
    
    // MARK: - Use Case - Track Analytics
    
    func presentTrackAnalytics(with response: MobiliteModels.TrackAnalytics.Response) {
        let viewModel = Models.TrackAnalytics.ViewModel()
        mobiliteViewController?.displayTrackAnalytics(with: viewModel)
    }
    
    // MARK: - Use Case - Mobilite
    
    func presentPerformMobilite(with response: MobiliteModels.PerformMobilite.Response) {
        var responseError = response.error
        
        if let error = responseError {
            switch error.type {
            case .emptyExampleVariable:
                responseError?.message = "Localized empty/nil error message."
                
            case .networkError:
                responseError?.message = "Localized network error message."
            }
        }
        
        let viewModel = Models.PerformMobilite.ViewModel(error: responseError)
        mobiliteViewController?.displayPerformMobilite(with: viewModel)
    }
    
    
    func showMobilities(responses: DemandeResponse, choix : Int){
        
        mobiliteViewController?.getData(response:responses, choix:choix)
    }
    
    func showMobilitiesForValidation(responses : DemandeResponse){
        mobiliteViewController?.getDataForValidation(response: responses)
    }
    
    func showMobilitiesForValidationError(){
        print("error -- 1 ")
    }
}
