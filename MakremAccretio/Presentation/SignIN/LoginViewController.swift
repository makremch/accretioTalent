//
//  LoginViewController.swift
//  MakremAccretio
//
//  Created by Makrem on 2/19/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit
import CDAlertView
import SVProgressHUD

protocol LoginDisplayLogic: class {
    func displayFetchFromLocalDataStore(with viewModel: LoginModels.FetchFromLocalDataStore.ViewModel)
    func displayFetchFromRemoteDataStore(with viewModel: LoginModels.FetchFromRemoteDataStore.ViewModel)
    func displayTrackAnalytics(with viewModel: LoginModels.TrackAnalytics.ViewModel)
    func displayPerformLogin(with viewModel: LoginModels.PerformLogin.ViewModel)
    func showMobilite()
    func showMobiliteCollaborator()
    func showMenuAfterLogin()
    func displaySignInError(viewModel: Error)
}

class LoginViewController: UIViewController, LoginDisplayLogic {
    
    
    
    
    
    
    func showMobiliteCollaborator(){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mobiliteCollaborateurviewController = storyBoard.instantiateViewController(withIdentifier: "mobiliteCollaborateurViewController") as! MobiliteCollaborateurViewController
        self.navigationController?.pushViewController(mobiliteCollaborateurviewController, animated: true)
    }
    
    
    func showMenuAfterLogin(){
        //        ProgressView.StopLoding()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let menu = storyBoard.instantiateViewController(withIdentifier: "menuVC") as! MenuViewController
        //          menu.modalPresentationStyle = .fullScreen
        
        //                  self.present(menu, animated: true, completion: nil)
        self.navigationController?.pushViewController(menu, animated: true)
    }
    
    func displaySignInError(viewModel: Error){
        //        ProgressView.StopLoding()
        let alert = CDAlertView(title: "Title", message: "Message", type: .error)
        let action = CDAlertViewAction(title: "DONE")
        alert.isTextFieldHidden = true
        alert.add(action: action)
        alert.hideAnimations = { (center, transform, alpha) in
            transform = .identity
            alpha = 0
        }
        alert.show() { (alert) in
            print("completed")
            
            
        }
        
    }
    
    
    func showMobilite(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mobiliteviewController = storyBoard.instantiateViewController(withIdentifier: "mobiliteViewController") as! MobiliteViewController
        mobiliteviewController.modalPresentationStyle = .fullScreen
        
        self.present(mobiliteviewController, animated: true, completion: nil)
    }
    // MARK: - Properties
    
    
    //    UI Definitions
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var seConnecterButton: UIButton!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBAction func seConnecterButtonClicked(_ sender: Any) {
        DispatchQueue.main.async {
            let _username = self.usernameField.text!
            let _password = self.passwordField.text!
            self.interactor?.login(username: _username, password: _password, clientCode: "mobile-int", grantType: "password", rememberMe: false)
        }
        
        
    }
    
    
    typealias Models = LoginModels
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    var interactor: LoginBusinessLogic?
    
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
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        
        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        seConnecterButton.layer.cornerRadius = 7
        super.viewDidLoad()
        setupFetchFromLocalDataStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchFromRemoteDataStore()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        trackScreenViewAnalytics()
        registerNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
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
    
    func displayFetchFromLocalDataStore(with viewModel: LoginModels.FetchFromLocalDataStore.ViewModel) {
        exampleLocalLabel.text = viewModel.exampleTranslation
    }
    
    // MARK: - Use Case - Fetch From Remote DataStore
    
    @IBOutlet var exampleRemoteLabel: UILabel! = UILabel()
    func setupFetchFromRemoteDataStore() {
        let request = Models.FetchFromRemoteDataStore.Request()
        interactor?.fetchFromRemoteDataStore(with: request)
    }
    
    func displayFetchFromRemoteDataStore(with viewModel: LoginModels.FetchFromRemoteDataStore.ViewModel) {
        exampleRemoteLabel.text = viewModel.exampleVariable
    }
    
    // MARK: - Use Case - Track Analytics
    
    @objc
    func trackScreenViewAnalytics() {
        trackAnalytics(event: .screenView)
    }
    
    func trackAnalytics(event: LoginModels.AnalyticsEvents) {
        let request = Models.TrackAnalytics.Request(event: event)
        interactor?.trackAnalytics(with: request)
    }
    
    func displayTrackAnalytics(with viewModel: LoginModels.TrackAnalytics.ViewModel) {
        // do something after tracking analytics (if needed)
    }
    
    // MARK: - Use Case - Login
    
    func performLogin(_ sender: Any) {
        let request = Models.PerformLogin.Request(exampleVariable: exampleLocalLabel.text)
        interactor?.performLogin(with: request)
    }
    
    func displayPerformLogin(with viewModel: LoginModels.PerformLogin.ViewModel) {
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
