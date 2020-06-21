//
//  DetailsMobiliteViewController.swift
//  MakremAccretio
//
//  Created by Makrem on 2/24/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol DetailsMobiliteDisplayLogic: class {
    func displayFetchFromLocalDataStore(with viewModel: DetailsMobiliteModels.FetchFromLocalDataStore.ViewModel)
    func displayFetchFromRemoteDataStore(with viewModel: DetailsMobiliteModels.FetchFromRemoteDataStore.ViewModel)
    func displayTrackAnalytics(with viewModel: DetailsMobiliteModels.TrackAnalytics.ViewModel)
    func displayPerformDetailsMobilite(with viewModel: DetailsMobiliteModels.PerformDetailsMobilite.ViewModel)
}

class DetailsMobiliteViewController: UIViewController, DetailsMobiliteDisplayLogic {

    // MARK: - Properties
    @IBOutlet weak var validerButton: UIButton!
    @IBOutlet weak var lieu: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var libelleLabel: UILabel!
    var demande : Demande?
    
    
   
    
    @IBAction func backToAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFetchFromLocalDataStore()
        self.navigationController?.navigationBar.backItem?.title = "Details demande"
        libelleLabel.text = demande?.labelOffer
        dateLabel.text = demande?.startDate
        codeLabel.text = demande?.codeOffer
        if demande?.localisationOffer?.count ?? 0 > 0 && demande?.localisationOffer != nil && demande?.localisationOffer != [] {
            lieu.text = demande?.localisationOffer?[0]
    }
    }
    


    typealias Models = DetailsMobiliteModels
    var router: (NSObjectProtocol & DetailsMobiliteRoutingLogic & DetailsMobiliteDataPassing)?
    var interactor: DetailsMobiliteBusinessLogic?

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
        let interactor = DetailsMobiliteInteractor()
        let presenter = DetailsMobilitePresenter()
        let router = DetailsMobiliteRouter()

        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - View Lifecycle

    

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

    func displayFetchFromLocalDataStore(with viewModel: DetailsMobiliteModels.FetchFromLocalDataStore.ViewModel) {
        exampleLocalLabel.text = viewModel.exampleTranslation
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    @IBOutlet var exampleRemoteLabel: UILabel! = UILabel()
    func setupFetchFromRemoteDataStore() {
        let request = Models.FetchFromRemoteDataStore.Request()
        interactor?.fetchFromRemoteDataStore(with: request)
    }

    func displayFetchFromRemoteDataStore(with viewModel: DetailsMobiliteModels.FetchFromRemoteDataStore.ViewModel) {
        exampleRemoteLabel.text = viewModel.exampleVariable
    }

    // MARK: - Use Case - Track Analytics

    @objc
    func trackScreenViewAnalytics() {
        trackAnalytics(event: .screenView)
    }

    func trackAnalytics(event: DetailsMobiliteModels.AnalyticsEvents) {
        let request = Models.TrackAnalytics.Request(event: event)
        interactor?.trackAnalytics(with: request)
    }

    func displayTrackAnalytics(with viewModel: DetailsMobiliteModels.TrackAnalytics.ViewModel) {
        // do something after tracking analytics (if needed)
    }

    // MARK: - Use Case - DetailsMobilite

    func performDetailsMobilite(_ sender: Any) {
        let request = Models.PerformDetailsMobilite.Request(exampleVariable: exampleLocalLabel.text)
        interactor?.performDetailsMobilite(with: request)
    }

    func displayPerformDetailsMobilite(with viewModel: DetailsMobiliteModels.PerformDetailsMobilite.ViewModel) {
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
