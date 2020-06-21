//
//  MobiliteCollaborateurPresenter.swift
//  MakremAccretio
//
//  Created by Makrem on 3/2/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol MobiliteCollaborateurPresentationLogic {
    func presentFetchFromLocalDataStore(with response: MobiliteCollaborateurModels.FetchFromLocalDataStore.Response)
    func presentFetchFromRemoteDataStore(with response: MobiliteCollaborateurModels.FetchFromRemoteDataStore.Response)
    func presentTrackAnalytics(with response: MobiliteCollaborateurModels.TrackAnalytics.Response)
    func presentPerformMobiliteCollaborateur(with response: MobiliteCollaborateurModels.PerformMobiliteCollaborateur.Response)
    func showMobilitiesCollaborator(responses: Response)
}

class MobiliteCollaborateurPresenter: MobiliteCollaborateurPresentationLogic {

    // MARK: - Properties

    typealias Models = MobiliteCollaborateurModels
    weak var viewController: MobiliteCollaborateurDisplayLogic?

    // MARK: - Use Case - Fetch From Local DataStore

    func presentFetchFromLocalDataStore(with response: MobiliteCollaborateurModels.FetchFromLocalDataStore.Response) {
        let translation = "Some localized text."
        let viewModel = Models.FetchFromLocalDataStore.ViewModel(exampleTranslation: translation)
        viewController?.displayFetchFromLocalDataStore(with: viewModel)
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    func presentFetchFromRemoteDataStore(with response: MobiliteCollaborateurModels.FetchFromRemoteDataStore.Response) {
        let formattedExampleVariable = response.exampleVariable ?? ""
        let viewModel = Models.FetchFromRemoteDataStore.ViewModel(exampleVariable: formattedExampleVariable)
        viewController?.displayFetchFromRemoteDataStore(with: viewModel)
    }

    // MARK: - Use Case - Track Analytics

    func presentTrackAnalytics(with response: MobiliteCollaborateurModels.TrackAnalytics.Response) {
        let viewModel = Models.TrackAnalytics.ViewModel()
        viewController?.displayTrackAnalytics(with: viewModel)
    }

    // MARK: - Use Case - MobiliteCollaborateur

    func presentPerformMobiliteCollaborateur(with response: MobiliteCollaborateurModels.PerformMobiliteCollaborateur.Response) {
        var responseError = response.error

        if let error = responseError {
            switch error.type {
            case .emptyExampleVariable:
                responseError?.message = "Localized empty/nil error message."

            case .networkError:
                responseError?.message = "Localized network error message."
            }
        }

        let viewModel = Models.PerformMobiliteCollaborateur.ViewModel(error: responseError)
        viewController?.displayPerformMobiliteCollaborateur(with: viewModel)
    }
    
    
    func showMobilitiesCollaborator(responses: Response){
        viewController?.getDataCollaborator(response:responses)
        
    }
    
    
    
    
}
