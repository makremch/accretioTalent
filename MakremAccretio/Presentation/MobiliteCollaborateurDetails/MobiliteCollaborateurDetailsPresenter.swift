//
//  MobiliteCollaborateurDetailsPresenter.swift
//  MakremAccretio
//
//  Created by Makrem on 3/3/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol MobiliteCollaborateurDetailsPresentationLogic {
    func presentFetchFromLocalDataStore(with response: MobiliteCollaborateurDetailsModels.FetchFromLocalDataStore.Response)
    func presentFetchFromRemoteDataStore(with response: MobiliteCollaborateurDetailsModels.FetchFromRemoteDataStore.Response)
    func presentTrackAnalytics(with response: MobiliteCollaborateurDetailsModels.TrackAnalytics.Response)
    func presentPerformMobiliteCollaborateurDetails(with response: MobiliteCollaborateurDetailsModels.PerformMobiliteCollaborateurDetails.Response)
    func getCodeCVgetCodeCVPresenter(response:CodeCv)
    func hidePostuler(hide:Bool)
    func presentError(response: Error)
    func presentAdd(response: Content)
    func presentErreurAdd(response: [ErreurAbsence])
}

class MobiliteCollaborateurDetailsPresenter: MobiliteCollaborateurDetailsPresentationLogic {
    func getCodeCVgetCodeCVPresenter(response: CodeCv) {
        self.viewController?.getCodeViewController(response: response)
    }
    func presentErreurAdd(response: [ErreurAbsence]) {
           print(response)
      }
      
    func presentAdd(response: Content) {
           viewController?.sucessUpload(response:response) 
       }
       
       func presentError(response: Error) {
           print(response)
       }
    // MARK: - Properties

    typealias Models = MobiliteCollaborateurDetailsModels
    weak var viewController: MobiliteCollaborateurDetailsDisplayLogic?

    // MARK: - Use Case - Fetch From Local DataStore

    func presentFetchFromLocalDataStore(with response: MobiliteCollaborateurDetailsModels.FetchFromLocalDataStore.Response) {
        let translation = "Some localized text."
        let viewModel = Models.FetchFromLocalDataStore.ViewModel(exampleTranslation: translation)
        viewController?.displayFetchFromLocalDataStore(with: viewModel)
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    func presentFetchFromRemoteDataStore(with response: MobiliteCollaborateurDetailsModels.FetchFromRemoteDataStore.Response) {
        let formattedExampleVariable = response.exampleVariable ?? ""
        let viewModel = Models.FetchFromRemoteDataStore.ViewModel(exampleVariable: formattedExampleVariable)
        viewController?.displayFetchFromRemoteDataStore(with: viewModel)
    }

    // MARK: - Use Case - Track Analytics

    func presentTrackAnalytics(with response: MobiliteCollaborateurDetailsModels.TrackAnalytics.Response) {
        let viewModel = Models.TrackAnalytics.ViewModel()
        viewController?.displayTrackAnalytics(with: viewModel)
    }

    // MARK: - Use Case - MobiliteCollaborateurDetails

    func presentPerformMobiliteCollaborateurDetails(with response: MobiliteCollaborateurDetailsModels.PerformMobiliteCollaborateurDetails.Response) {
        var responseError = response.error

        if let error = responseError {
            switch error.type {
            case .emptyExampleVariable:
                responseError?.message = "Localized empty/nil error message."

            case .networkError:
                responseError?.message = "Localized network error message."
            }
        }

        let viewModel = Models.PerformMobiliteCollaborateurDetails.ViewModel(error: responseError)
        viewController?.displayPerformMobiliteCollaborateurDetails(with: viewModel)
    }
    
    
    
    func getCodeCVPresenter(response:CodeCv){
     
    }
    
    
    func hidePostuler(hide: Bool){
        self.viewController?.hidePostuler(hide: hide)
    }
}
