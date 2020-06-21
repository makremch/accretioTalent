//
//  MenuViewController.swift
//  MakremAccretio
//
//  Created by Makrem on 3/31/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol MenuDisplayLogic: class {
    func displayFetchFromLocalDataStore(with viewModel: MenuModels.FetchFromLocalDataStore.ViewModel)
    func displayFetchFromRemoteDataStore(with viewModel: MenuModels.FetchFromRemoteDataStore.ViewModel)
    func displayTrackAnalytics(with viewModel: MenuModels.TrackAnalytics.ViewModel)
    func displayPerformMenu(with viewModel: MenuModels.PerformMenu.ViewModel)
}

class MenuViewController: UIViewController, MenuDisplayLogic {
    
    
    // MARK: - Initialisation Boutlets
    

    @IBOutlet weak var MobiliteInterneButton: UIButton!
    @IBOutlet weak var demandeRecrutementButton: UIButton!
    
    @IBOutlet weak var TitleView: UIView!
    @IBOutlet weak var recrutementView: UIView!
    @IBOutlet weak var MobiliteView: UIView!
    @IBOutlet weak var competencesView: UIView!
    @IBOutlet weak var formationView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    func designMenu(){
        // corner Radius
        recrutementView.layer.cornerRadius = 10
        MobiliteView.layer.cornerRadius = 10
        competencesView.layer.cornerRadius = 10
        formationView.layer.cornerRadius = 10
        TitleView.layer.cornerRadius = 30
        
        recrutementView.layer.shadowColor = UIColor.gray.cgColor
        recrutementView.layer.shadowOpacity = 10
        recrutementView.layer.shadowOffset = .zero
        recrutementView.layer.shadowRadius = 15
        recrutementView.layer.shadowPath = UIBezierPath(rect: recrutementView.bounds).cgPath
        recrutementView.layer.shouldRasterize = true
        recrutementView.layer.rasterizationScale = UIScreen.main.scale
        
        
        MobiliteView.layer.shadowColor = UIColor.gray.cgColor
        MobiliteView.layer.shadowOpacity = 10
        MobiliteView.layer.shadowOffset = .zero
        MobiliteView.layer.shadowRadius = 15
        MobiliteView.layer.shadowPath = UIBezierPath(rect: MobiliteView.bounds).cgPath
        MobiliteView.layer.shouldRasterize = true
        MobiliteView.layer.rasterizationScale = UIScreen.main.scale
        
        
        competencesView.layer.shadowColor = UIColor.gray.cgColor
        competencesView.layer.shadowOpacity = 10
        competencesView.layer.shadowOffset = .zero
        competencesView.layer.shadowRadius = 15
        competencesView.layer.shadowPath = UIBezierPath(rect: competencesView.bounds).cgPath
        competencesView.layer.shouldRasterize = true
        competencesView.layer.rasterizationScale = UIScreen.main.scale
        
        
        
        formationView.layer.shadowColor = UIColor.gray.cgColor
        formationView.layer.shadowOpacity = 10
        formationView.layer.shadowOffset = .zero
        formationView.layer.shadowRadius = 15
        formationView.layer.shadowPath = UIBezierPath(rect: formationView.bounds).cgPath
        formationView.layer.shouldRasterize = true
        formationView.layer.rasterizationScale = UIScreen.main.scale
        
        
        
        TitleView.layer.shadowColor = UIColor.gray.cgColor
        TitleView.layer.shadowOpacity = 10
        TitleView.layer.shadowOffset = .zero
        TitleView.layer.shadowRadius = 15
        TitleView.layer.shadowPath = UIBezierPath(rect: TitleView.bounds).cgPath
        TitleView.layer.shouldRasterize = true
        TitleView.layer.rasterizationScale = UIScreen.main.scale
        
       
    }
    

    // MARK: - Properties

    typealias Models = MenuModels
    var router: (NSObjectProtocol & MenuRoutingLogic & MenuDataPassing)?
    var interactor: MenuBusinessLogic?

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
        let interactor = MenuInteractor()
        let presenter = MenuPresenter()
        let router = MenuRouter()

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
        userNameLabel.text = "Bonjour, " + (UserDefaults.standard.string(forKey: "nameOfUser")!)
        designMenu()
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

    func displayFetchFromLocalDataStore(with viewModel: MenuModels.FetchFromLocalDataStore.ViewModel) {
        exampleLocalLabel.text = viewModel.exampleTranslation
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    @IBOutlet var exampleRemoteLabel: UILabel! = UILabel()
    func setupFetchFromRemoteDataStore() {
        let request = Models.FetchFromRemoteDataStore.Request()
        interactor?.fetchFromRemoteDataStore(with: request)
    }

    func displayFetchFromRemoteDataStore(with viewModel: MenuModels.FetchFromRemoteDataStore.ViewModel) {
        exampleRemoteLabel.text = viewModel.exampleVariable
    }

    // MARK: - Use Case - Track Analytics

    @objc
    func trackScreenViewAnalytics() {
        trackAnalytics(event: .screenView)
    }

    func trackAnalytics(event: MenuModels.AnalyticsEvents) {
        let request = Models.TrackAnalytics.Request(event: event)
        interactor?.trackAnalytics(with: request)
    }

    func displayTrackAnalytics(with viewModel: MenuModels.TrackAnalytics.ViewModel) {
        // do something after tracking analytics (if needed)
    }

    // MARK: - Use Case - Menu

    func performMenu(_ sender: Any) {
        let request = Models.PerformMenu.Request(exampleVariable: exampleLocalLabel.text)
        interactor?.performMenu(with: request)
    }

    func displayPerformMenu(with viewModel: MenuModels.PerformMenu.ViewModel) {
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
