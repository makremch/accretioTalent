//
//  createPostulerPresenter.swift
//  MakremAccretio
//
//  Created by Makrem on 3/30/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol createPostulerPresentationLogic {
    func presentFetchFromLocalDataStore(with response: createPostulerModels.FetchFromLocalDataStore.Response)
    func presentFetchFromRemoteDataStore(with response: createPostulerModels.FetchFromRemoteDataStore.Response)
    func presentTrackAnalytics(with response: createPostulerModels.TrackAnalytics.Response)
    func presentPerformcreatePostuler(with response: createPostulerModels.PerformcreatePostuler.Response)
    func presentError(response: Error)
    func presentAdd(response: Content)
}

class createPostulerPresenter: createPostulerPresentationLogic {
    func presentAdd(response: Content) {
        viewController?.sucessUpload(response:response) 
    }
    
    func presentError(response: Error) {
        print(response)
    }
    

    // MARK: - Properties

    typealias Models = createPostulerModels
    weak var viewController: createPostulerDisplayLogic?

    // MARK: - Use Case - Fetch From Local DataStore

    func presentFetchFromLocalDataStore(with response: createPostulerModels.FetchFromLocalDataStore.Response) {
        let translation = "Some localized text."
        let viewModel = Models.FetchFromLocalDataStore.ViewModel(exampleTranslation: translation)
        viewController?.displayFetchFromLocalDataStore(with: viewModel)
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    func presentFetchFromRemoteDataStore(with response: createPostulerModels.FetchFromRemoteDataStore.Response) {
        let formattedExampleVariable = response.exampleVariable ?? ""
        let viewModel = Models.FetchFromRemoteDataStore.ViewModel(exampleVariable: formattedExampleVariable)
        viewController?.displayFetchFromRemoteDataStore(with: viewModel)
    }

    // MARK: - Use Case - Track Analytics

    func presentTrackAnalytics(with response: createPostulerModels.TrackAnalytics.Response) {
        let viewModel = Models.TrackAnalytics.ViewModel()
        viewController?.displayTrackAnalytics(with: viewModel)
    }

    // MARK: - Use Case - createPostuler

    func presentPerformcreatePostuler(with response: createPostulerModels.PerformcreatePostuler.Response) {
        var responseError = response.error

        if let error = responseError {
            switch error.type {
            case .emptyExampleVariable:
                responseError?.message = "Localized empty/nil error message."

            case .networkError:
                responseError?.message = "Localized network error message."
            }
        }

        let viewModel = Models.PerformcreatePostuler.ViewModel(error: responseError)
        viewController?.displayPerformcreatePostuler(with: viewModel)
    }
}
