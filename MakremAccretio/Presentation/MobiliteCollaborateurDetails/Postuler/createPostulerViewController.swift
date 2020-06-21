//
//  createPostulerViewController.swift
//  MakremAccretio
//
//  Created by Makrem on 3/30/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol createPostulerDisplayLogic: class {
    func displayFetchFromLocalDataStore(with viewModel: createPostulerModels.FetchFromLocalDataStore.ViewModel)
    func displayFetchFromRemoteDataStore(with viewModel: createPostulerModels.FetchFromRemoteDataStore.ViewModel)
    func displayTrackAnalytics(with viewModel: createPostulerModels.TrackAnalytics.ViewModel)
    func displayPerformcreatePostuler(with viewModel: createPostulerModels.PerformcreatePostuler.ViewModel)
       func sucessUpload(response: Content)
}

class createPostulerViewController: UIViewController, createPostulerDisplayLogic {

    // MARK: - Properties

    typealias Models = createPostulerModels
    var router: (NSObjectProtocol & createPostulerRoutingLogic & createPostulerDataPassing)?
    var interactor: createPostulerBusinessLogic?

    // MARK: - Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup

    private func setup() {
        let viewController = self
        let interactor = createPostulerInteractor()
        let presenter = createPostulerPresenter()
        let router = createPostulerRouter()

        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFetchFromLocalDataStore()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchFromRemoteDataStore()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        trackScreenViewAnalytics()
        registerNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterNotifications()
    }

    func sucessUpload(response: Content) {
           print(response)
       }
    // MARK: - Notifications

    func registerNotifications() {
        let selector = #selector(trackScreenViewAnalytics)
        let notification = UIApplication.didBecomeActiveNotification
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }

    func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Use Case - Fetch From Local DataStore

    @IBOutlet var exampleLocalLabel: UILabel! = UILabel()
    func setupFetchFromLocalDataStore() {
        let request = Models.FetchFromLocalDataStore.Request()
        interactor?.fetchFromLocalDataStore(with: request)
    }

    func displayFetchFromLocalDataStore(with viewModel: createPostulerModels.FetchFromLocalDataStore.ViewModel) {
        exampleLocalLabel.text = viewModel.exampleTranslation
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    @IBOutlet var exampleRemoteLabel: UILabel! = UILabel()
    func setupFetchFromRemoteDataStore() {
        let request = Models.FetchFromRemoteDataStore.Request()
        interactor?.fetchFromRemoteDataStore(with: request)
    }

    func displayFetchFromRemoteDataStore(with viewModel: createPostulerModels.FetchFromRemoteDataStore.ViewModel) {
        exampleRemoteLabel.text = viewModel.exampleVariable
    }

    // MARK: - Use Case - Track Analytics

    @objc
    func trackScreenViewAnalytics() {
        trackAnalytics(event: .screenView)
    }

    func trackAnalytics(event: createPostulerModels.AnalyticsEvents) {
        let request = Models.TrackAnalytics.Request(event: event)
        interactor?.trackAnalytics(with: request)
    }

    func displayTrackAnalytics(with viewModel: createPostulerModels.TrackAnalytics.ViewModel) {
        // do something after tracking analytics (if needed)
    }

    // MARK: - Use Case - createPostuler

    func performcreatePostuler(_ sender: Any) {
        let request = Models.PerformcreatePostuler.Request(exampleVariable: exampleLocalLabel.text)
        interactor?.performcreatePostuler(with: request)
    }

    func displayPerformcreatePostuler(with viewModel: createPostulerModels.PerformcreatePostuler.ViewModel) {
        // handle error and ui element error states
        // based on error type
        if let error = viewModel.error {
            switch error.type {
            case .emptyExampleVariable:
                exampleLocalLabel.text = error.message

            case .networkError:
                exampleLocalLabel.text = error.message
            }

            return
        }

        // handle ui element success state and
        // route to next screen
        router?.routeToNext()
    }
}
