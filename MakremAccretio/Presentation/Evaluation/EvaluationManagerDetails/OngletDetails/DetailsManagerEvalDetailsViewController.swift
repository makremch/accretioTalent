//
//  DetailsManagerEvalDetailsViewController.swift
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
import Charts


protocol DetailsManagerEvalDetailsDisplayLogic: class
{
    func displaySomething(viewModel: DetailsManagerEvalDetails.Something.ViewModel)
    func displayDataManagerDetails(responses : EvaluationManagerDetailsResponse)
}

class DetailsManagerEvalDetailsViewController: UIViewController, DetailsManagerEvalDetailsDisplayLogic
{
    var interactor: DetailsManagerEvalDetailsBusinessLogic?
    var router: (NSObjectProtocol & DetailsManagerEvalDetailsRoutingLogic & DetailsManagerEvalDetailsDataPassing)?
    
    
    //    MARK: IBOutlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var evaluatorsEvalueView: UIView!
    @IBOutlet weak var evaluateurLabel: UILabel!
    
    @IBOutlet weak var evaluationView: UIView!
    @IBOutlet weak var autoEvalLabel: UILabel!
    @IBOutlet weak var managerOneLabel: UILabel!
    @IBOutlet weak var managerTwoLabel: UILabel!
    @IBOutlet weak var signatureLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var validateStatusNumber: UILabel!
    @IBOutlet weak var inProgressLabel: UILabel!
    
    
    
    @IBOutlet weak var pieChartView: PieChartView!
    
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
        let interactor = DetailsManagerEvalDetailsInteractor()
        let presenter = DetailsManagerEvalDetailsPresenter()
        let router = DetailsManagerEvalDetailsRouter()
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
        designingViews ()
        let token = UserDefaults.standard.string(forKey: "accessToken")!
        let code = UserDefaults.standard.string(forKey: "codeEvalManager")!
        self.interactor?.showEvaluationsManagerDetails(token: token, code: code)
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = DetailsManagerEvalDetails.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: DetailsManagerEvalDetails.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    func designingViews (){
        evaluatorsEvalueView.layer.cornerRadius = 10
        evaluationView.layer.cornerRadius = 10
        
    }
    func displayDataManagerDetails(responses : EvaluationManagerDetailsResponse){
        print(responses)
        label.text = String((responses.evaluated?.count)!)
        evaluateurLabel.text = String((responses.evaluators?.count)!)
        autoEvalLabel.text = String((responses.evaluated?.count)!)
        managerOneLabel.text = "0"
        managerTwoLabel.text = "0"
        signatureLabel.text = "0"
        validateStatusNumber.text = String((responses.cardsValidStatusNumber)!)
        inProgressLabel.text = String((responses.cardsInprogressStatusNumber)!)
    }
    
    
}
