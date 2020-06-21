//
//  MenuInteractor.swift
//  MakremAccretio
//
//  Created by Makrem on 3/31/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol MenuBusinessLogic {
    func fetchFromLocalDataStore(with request: MenuModels.FetchFromLocalDataStore.Request)
    func fetchFromRemoteDataStore(with request: MenuModels.FetchFromRemoteDataStore.Request)
    func trackAnalytics(with request: MenuModels.TrackAnalytics.Request)
    func performMenu(with request: MenuModels.PerformMenu.Request)
}

protocol MenuDataStore {
    var exampleVariable: String? { get set }
}

class MenuInteractor: MenuBusinessLogic, MenuDataStore {

    // MARK: - Properties

    typealias Models = MenuModels

    lazy var worker = MenuWorker()
    var presenter: MenuPresentationLogic?

    var exampleVariable: String?

    // MARK: - Use Case - Fetch From Local DataStore

    func fetchFromLocalDataStore(with request: MenuModels.FetchFromLocalDataStore.Request) {
        let response = Models.FetchFromLocalDataStore.Response()
        presenter?.presentFetchFromLocalDataStore(with: response)
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    func fetchFromRemoteDataStore(with request: MenuModels.FetchFromRemoteDataStore.Request) {
        // fetch something from backend and return the values here
        // <#Network Worker Instance#>.fetchFromRemoteDataStore(completion: { [weak self] code in
        //     let response = Models.FetchFromRemoteDataStore.Response(exampleVariable: code)
        //     self?.presenter?.presentFetchFromRemoteDataStore(with: response)
        // })
    }

    // MARK: - Use Case - Track Analytics

    func trackAnalytics(with request: MenuModels.TrackAnalytics.Request) {
        // call analytics library/wrapper here to track analytics
        // <#Analytics Worker Instance#>.trackAnalytics(event: request.event)

        let response = Models.TrackAnalytics.Response()
        presenter?.presentTrackAnalytics(with: response)
    }

    // MARK: - Use Case - Menu

    func performMenu(with request: MenuModels.PerformMenu.Request) {
        let error = worker.validate(exampleVariable: request.exampleVariable)

        if let error = error {
            let response = Models.PerformMenu.Response(error: error)
            presenter?.presentPerformMenu(with: response)
            return
        }

        // <#Network Worker Instance#>.performMenu(completion: { [weak self, weak request] isSuccessful, error in
        //     self?.completion(request?.exampleVariable, isSuccessful, error)
        // })
    }

    private func completion(_ exampleVariable: String?, _ isSuccessful: Bool, _ error: Models.MenuError?) {
        if isSuccessful {
            // do something on success
            let goodExample = exampleVariable ?? ""
            self.exampleVariable = goodExample
        }

        let response = Models.PerformMenu.Response(error: error)
        presenter?.presentPerformMenu(with: response)
    }
}
