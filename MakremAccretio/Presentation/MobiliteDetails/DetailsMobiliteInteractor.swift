//
//  DetailsMobiliteInteractor.swift
//  MakremAccretio
//
//  Created by Makrem on 2/24/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol DetailsMobiliteBusinessLogic {
    func fetchFromLocalDataStore(with request: DetailsMobiliteModels.FetchFromLocalDataStore.Request)
    func fetchFromRemoteDataStore(with request: DetailsMobiliteModels.FetchFromRemoteDataStore.Request)
    func trackAnalytics(with request: DetailsMobiliteModels.TrackAnalytics.Request)
    func performDetailsMobilite(with request: DetailsMobiliteModels.PerformDetailsMobilite.Request)
}

protocol DetailsMobiliteDataStore {
    var exampleVariable: String? { get set }
}

class DetailsMobiliteInteractor: DetailsMobiliteBusinessLogic, DetailsMobiliteDataStore {

    // MARK: - Properties

    typealias Models = DetailsMobiliteModels

    lazy var worker = DetailsMobiliteWorker()
    var presenter: DetailsMobilitePresentationLogic?

    var exampleVariable: String?

    // MARK: - Use Case - Fetch From Local DataStore

    func fetchFromLocalDataStore(with request: DetailsMobiliteModels.FetchFromLocalDataStore.Request) {
        let response = Models.FetchFromLocalDataStore.Response()
        presenter?.presentFetchFromLocalDataStore(with: response)
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    func fetchFromRemoteDataStore(with request: DetailsMobiliteModels.FetchFromRemoteDataStore.Request) {
        // fetch something from backend and return the values here
        // <#Network Worker Instance#>.fetchFromRemoteDataStore(completion: { [weak self] code in
        //     let response = Models.FetchFromRemoteDataStore.Response(exampleVariable: code)
        //     self?.presenter?.presentFetchFromRemoteDataStore(with: response)
        // })
    }

    // MARK: - Use Case - Track Analytics

    func trackAnalytics(with request: DetailsMobiliteModels.TrackAnalytics.Request) {
        // call analytics library/wrapper here to track analytics
        // <#Analytics Worker Instance#>.trackAnalytics(event: request.event)

        let response = Models.TrackAnalytics.Response()
        presenter?.presentTrackAnalytics(with: response)
    }

    // MARK: - Use Case - DetailsMobilite

    func performDetailsMobilite(with request: DetailsMobiliteModels.PerformDetailsMobilite.Request) {
        let error = worker.validate(exampleVariable: request.exampleVariable)

        if let error = error {
            let response = Models.PerformDetailsMobilite.Response(error: error)
            presenter?.presentPerformDetailsMobilite(with: response)
            return
        }

        // <#Network Worker Instance#>.performDetailsMobilite(completion: { [weak self, weak request] isSuccessful, error in
        //     self?.completion(request?.exampleVariable, isSuccessful, error)
        // })
    }

    private func completion(_ exampleVariable: String?, _ isSuccessful: Bool, _ error: Models.DetailsMobiliteError?) {
        if isSuccessful {
            // do something on success
            let goodExample = exampleVariable ?? ""
            self.exampleVariable = goodExample
        }

        let response = Models.PerformDetailsMobilite.Response(error: error)
        presenter?.presentPerformDetailsMobilite(with: response)
    }
}
