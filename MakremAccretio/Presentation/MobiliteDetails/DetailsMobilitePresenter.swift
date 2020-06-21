//
//  DetailsMobilitePresenter.swift
//  MakremAccretio
//
//  Created by Makrem on 2/24/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol DetailsMobilitePresentationLogic {
    func presentFetchFromLocalDataStore(with response: DetailsMobiliteModels.FetchFromLocalDataStore.Response)
    func presentFetchFromRemoteDataStore(with response: DetailsMobiliteModels.FetchFromRemoteDataStore.Response)
    func presentTrackAnalytics(with response: DetailsMobiliteModels.TrackAnalytics.Response)
    func presentPerformDetailsMobilite(with response: DetailsMobiliteModels.PerformDetailsMobilite.Response)
}

class DetailsMobilitePresenter: DetailsMobilitePresentationLogic {

    // MARK: - Properties

    typealias Models = DetailsMobiliteModels
    weak var viewController: DetailsMobiliteDisplayLogic?

    // MARK: - Use Case - Fetch From Local DataStore

    func presentFetchFromLocalDataStore(with response: DetailsMobiliteModels.FetchFromLocalDataStore.Response) {
        let translation = "Some localized text."
        let viewModel = Models.FetchFromLocalDataStore.ViewModel(exampleTranslation: translation)
        viewController?.displayFetchFromLocalDataStore(with: viewModel)
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    func presentFetchFromRemoteDataStore(with response: DetailsMobiliteModels.FetchFromRemoteDataStore.Response) {
        let formattedExampleVariable = response.exampleVariable ?? ""
        let viewModel = Models.FetchFromRemoteDataStore.ViewModel(exampleVariable: formattedExampleVariable)
        viewController?.displayFetchFromRemoteDataStore(with: viewModel)
    }

    // MARK: - Use Case - Track Analytics

    func presentTrackAnalytics(with response: DetailsMobiliteModels.TrackAnalytics.Response) {
        let viewModel = Models.TrackAnalytics.ViewModel()
        viewController?.displayTrackAnalytics(with: viewModel)
    }

    // MARK: - Use Case - DetailsMobilite

    func presentPerformDetailsMobilite(with response: DetailsMobiliteModels.PerformDetailsMobilite.Response) {
        var responseError = response.error

        if let error = responseError {
            switch error.type {
            case .emptyExampleVariable:
                responseError?.message = "Localized empty/nil error message."

            case .networkError:
                responseError?.message = "Localized network error message."
            }
        }

        let viewModel = Models.PerformDetailsMobilite.ViewModel(error: responseError)
        viewController?.displayPerformDetailsMobilite(with: viewModel)
    }
}
