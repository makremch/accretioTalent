//
//  ManagerEvaluationDetailsViewController.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/23/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ManagerEvaluationDetailsDisplayLogic: class
{
    func displaySomething(viewModel: ManagerEvaluationDetails.Something.ViewModel)
    func displayDataManagerDetails(responses : EvaluationManagerDetailsResponse)
}

class ManagerEvaluationDetailsViewController: UIViewController, ManagerEvaluationDetailsDisplayLogic
{
    
//    MARK:- Let & Var
    var interactor: ManagerEvaluationDetailsBusinessLogic?
    var router: (NSObjectProtocol & ManagerEvaluationDetailsRoutingLogic & ManagerEvaluationDetailsDataPassing)?
    var content : ManagerEvaluation? = nil
    var dataDetailsManagerEvaluation : EvaluationManagerDetailsResponse? = nil

    
    //    MARK:- IBOutlets
    @IBOutlet weak var EvaluatedView: UIView!
    @IBOutlet weak var ActionsView: UIView!
    @IBOutlet weak var DetailsView: UIView!
    @IBOutlet weak var CompetenceManagerDetailsLabel: UILabel!
    @IBOutlet weak var segmentedControllerSeg: UISegmentedControl!
    
    
//    MARK:- IBOutlets Actions
    @IBAction func changeViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            EvaluatedView.alpha = 1
            ActionsView.alpha = 0
            DetailsView.alpha = 0
        }else if sender.selectedSegmentIndex == 1 {
            EvaluatedView.alpha = 0
            ActionsView.alpha = 0
            DetailsView.alpha = 1
        }else if sender.selectedSegmentIndex == 2{
            EvaluatedView.alpha = 0
            ActionsView.alpha = 1
            DetailsView.alpha = 0
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        UserDefaults.standard.removeObject(forKey: "codeEvalManager")
    }
    
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ManagerEvaluationDetailsInteractor()
        let presenter = ManagerEvaluationDetailsPresenter()
        let router = ManagerEvaluationDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        doSomething()
        let token = UserDefaults.standard.string(forKey: "accessToken")!
        let code = UserDefaults.standard.string(forKey: "codeEvalManager")!
        self.interactor?.showEvaluationsManagerDetails(token: token, code: code)
        CompetenceManagerDetailsLabel.text = content?.label
        
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = ManagerEvaluationDetails.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: ManagerEvaluationDetails.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    func displayDataManagerDetails(responses : EvaluationManagerDetailsResponse){
        print(responses)
        dataDetailsManagerEvaluation = responses
        
    }
    
}
