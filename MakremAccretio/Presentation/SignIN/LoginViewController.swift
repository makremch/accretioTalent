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
    
    var  iconClick = false

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
        
        let icon_pw = UIImage(systemName: "lock")
        let but_pw = UIImage(systemName: "eye.slash")
        let iconMail = UIImage(systemName: "person.circle")
        styleTextFields(passwordField, andImage: icon_pw!, andrightbut: but_pw)
        styleTextFields(usernameField, andImage: iconMail!, andrightbut:nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setupKeyboardDismissRecognizer()
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

extension LoginViewController{
    
    func styleTextFields(_ textfield:UITextField, andImage img: UIImage,andrightbut butImg: UIImage?) {
        
        let textfieldLine = CALayer()
        textfieldLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        
        textfield.tintColor             = .black
        textfield.textColor             = .black
        textfield.backgroundColor       = UIColor(red: 28/255, green: 123/255, blue: 161/255, alpha: 1)
        textfield.autocorrectionType    = .no
        textfield.layer.cornerRadius    = 5
        textfield.layer.borderWidth     = 0
        textfield.clipsToBounds         = true
        textfield.clearButtonMode = .always
        textfield.clearButtonMode = .whileEditing
        
        
        textfield.layer.addSublayer(textfieldLine)
        
        
        let iconView = UIImageView(frame:
            CGRect(x:20, y: 0, width: 20, height: 20))
        iconView.image = img
        
        let iconContainerView: UIView = UIView(frame:
            CGRect(x:0, y: 0, width: 45, height: 20))
        iconContainerView.addSubview(iconView)
        
        textfield.leftView = iconContainerView
        textfield.leftViewMode          = .always
        
        
        
        let button = UIButton(type: .custom)
        button.tintColor = .black
        button.setImage(butImg, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right:10)
        button.frame = CGRect(x: CGFloat(textfield.frame.size.width - 15), y: CGFloat(5), width: CGFloat(10), height: CGFloat(10))
        button.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        
        
        textfield.rightView = button
        textfield.rightViewMode = .always
    }
    
    @objc  func showPassword(){
        
        if(iconClick == true) {
            passwordField.isSecureTextEntry = false
            let icon_pw = UIImage(systemName: "lock")
            let but_pw = UIImage(systemName: "eye")
            
            styleTextFields(passwordField, andImage: icon_pw!, andrightbut: but_pw)
            
        } else {
            passwordField.isSecureTextEntry = true
            let icon_pw = UIImage(systemName: "lock")
            let but_pw = UIImage(systemName: "eye.slash")
            styleTextFields(passwordField, andImage: icon_pw!, andrightbut: but_pw)
        }
        
        iconClick = !iconClick
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
          if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
              if self.view.frame.origin.y == 0 {
                  self.view.frame.origin.y -= keyboardSize.height/2
              }
          }
      }
      @objc func keyboardWillHide(notification: NSNotification) {
          if self.view.frame.origin.y != 0 {
              self.view.frame.origin.y = 0
          }
      }
       func setupKeyboardDismissRecognizer(){
           let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
               target: self,
               action: #selector(dismissKeyboard))
           view.addGestureRecognizer(tapRecognizer)
       }
       @objc func dismissKeyboard(_ views: UIView)
       {
           view.endEditing(true)
       }
    
}
