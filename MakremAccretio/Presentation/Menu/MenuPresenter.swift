//
//  MenuPresenter.swift
//  MakremAccretio
//
//  Created by Makrem on 3/31/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol MenuPresentationLogic {
    func presentFetchFromLocalDataStore(with response: MenuModels.FetchFromLocalDataStore.Response)
    func presentFetchFromRemoteDataStore(with response: MenuModels.FetchFromRemoteDataStore.Response)
    func presentTrackAnalytics(with response: MenuModels.TrackAnalytics.Response)
    func presentPerformMenu(with response: MenuModels.PerformMenu.Response)
}

class MenuPresenter: MenuPresentationLogic {

    // MARK: - Properties

    typealias Models = MenuModels
    weak var viewController: MenuDisplayLogic?

    // MARK: - Use Case - Fetch From Local DataStore

    func presentFetchFromLocalDataStore(with response: MenuModels.FetchFromLocalDataStore.Response) {
        let translation = "Some localized text."
        let viewModel = Models.FetchFromLocalDataStore.ViewModel(exampleTranslation: translation)
        viewController?.displayFetchFromLocalDataStore(with: viewModel)
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    func presentFetchFromRemoteDataStore(with response: MenuModels.FetchFromRemoteDataStore.Response) {
        let formattedExampleVariable = response.exampleVariable ?? ""
        let viewModel = Models.FetchFromRemoteDataStore.ViewModel(exampleVariable: formattedExampleVariable)
        viewController?.displayFetchFromRemoteDataStore(with: viewModel)
    }

    // MARK: - Use Case - Track Analytics

    func presentTrackAnalytics(with response: MenuModels.TrackAnalytics.Response) {
        let viewModel = Models.TrackAnalytics.ViewModel()
        viewController?.displayTrackAnalytics(with: viewModel)
    }

    // MARK: - Use Case - Menu

    func presentPerformMenu(with response: MenuModels.PerformMenu.Response) {
        var responseError = response.error

        if let error = responseError {
            switch error.type {
            case .emptyExampleVariable:
                responseError?.message = "Localized empty/nil error message."

            case .networkError:
                responseError?.message = "Localized network error message."
            }
        }

        let viewModel = Models.PerformMenu.ViewModel(error: responseError)
        viewController?.displayPerformMenu(with: viewModel)
    }
}
