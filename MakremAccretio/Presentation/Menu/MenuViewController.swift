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
    @IBOutlet weak var EvaluationView: UIView!
    @IBOutlet weak var employeTypeLabel: UILabel!
    
    @IBOutlet var AllView: UIView!
    
    func designMenu(){
        
        //        MARK:- Blur effect
        let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurredView.frame = self.view.bounds
        
        // MARK:- Corner Radius
        recrutementView.layer.cornerRadius = 20
        MobiliteView.layer.cornerRadius = 20
        competencesView.layer.cornerRadius = 20
        formationView.layer.cornerRadius = 20
        EvaluationView.layer.cornerRadius = 20
        
        TitleView.layer.cornerRadius = TitleView.frame.size.width/2
        TitleView.layer.masksToBounds = false
        TitleView.clipsToBounds = true
        TitleView.layer.borderColor = UIColor.white.cgColor
        TitleView.layer.borderWidth = 1.0
        
//        MARK: - Shadow
        self.shadowApply(view: recrutementView)
        self.shadowApply(view: MobiliteView)
        self.shadowApply(view: competencesView)
        self.shadowApply(view: formationView)
        self.shadowApply(view: EvaluationView)
    }
    
    func shadowApply(view : UIView){
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0 , height:2)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        designMenu()
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
        userNameLabel.text = (UserDefaults.standard.string(forKey: "nameOfUser")!) + " " + (UserDefaults.standard.string(forKey: "lastNameOfUser")!)
        employeTypeLabel.text = (UserDefaults.standard.string(forKey: "employeType"))!
       
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
    
    @IBAction func MobiliteInterneBtn(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mobiliteC = storyBoard.instantiateViewController(withIdentifier: "mobiliteCollaborateurVC") as! MobiliteCollaborateurViewController
        self.navigationController?.pushViewController(mobiliteC, animated: true)
        
    }
    
    @IBAction func EvaluationBtn(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Evaluation", bundle: nil)
        let evaluationC = storyBoard.instantiateViewController(withIdentifier: "MenuEval") as! menuEvalViewController
        self.navigationController?.pushViewController(evaluationC, animated: true)
        
    }
    @IBAction func MobiliteCollabBtn(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mobiliteCC = storyBoard.instantiateViewController(withIdentifier: "mobiliteVC") as! MobiliteViewController
        self.navigationController?.pushViewController(mobiliteCC, animated: true)
        
    }
    
    @IBAction func formationBtn(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let formationC = storyBoard.instantiateViewController(withIdentifier: "MenuFormation") as! MenuFormationViewController
        formationC.titleScreen = "Formations"
        self.navigationController?.pushViewController(formationC, animated: true)
        
    }
    @IBAction func CompetenceCollabBtn(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let comptenceC = storyBoard.instantiateViewController(withIdentifier: "MenuFormation") as! MenuFormationViewController
        comptenceC.titleScreen = "Competences"
        self.navigationController?.pushViewController(comptenceC, animated: true)
        
    }
    
}
