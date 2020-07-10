//
//  EvaluationCollaborateurViewController.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 6/28/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol EvaluationCollaborateurDisplayLogic: class
{
    func displaySomething(viewModel: EvaluationCollaborateur.Something.ViewModel)
    func displayData(response : EvaluationResponse)
}

class EvaluationCollaborateurViewController: UIViewController, EvaluationCollaborateurDisplayLogic,UITableViewDelegate,UITableViewDataSource
{
//    MARK:- var and let declarations:
    var interactor: EvaluationCollaborateurBusinessLogic?
    var router: (NSObjectProtocol & EvaluationCollaborateurRoutingLogic & EvaluationCollaborateurDataPassing)?
    var evaluationCollab : [EvaluationCollab] = []
    
    //    MARK:- IBOutlets
    @IBOutlet weak var table: UITableView!
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        let interactor = EvaluationCollaborateurInteractor()
        let presenter = EvaluationCollaborateurPresenter()
        let router = EvaluationCollaborateurRouter()
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
        let token = UserDefaults.standard.string(forKey: "accessToken")!
        self.interactor?.showEvaluationsCollaborateur(token: token)
        doSomething()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = EvaluationCollaborateur.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: EvaluationCollaborateur.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    
//    MARK:- TableView Configuration
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return evaluationCollab.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cell = tableView.dequeueReusableCell(withIdentifier: "EvalCell", for: indexPath) as?
            EvaluationViewControllerCell
            else {
                return UITableViewCell()
        }
        
        
        let startDates = (evaluationCollab[indexPath.row].startDate).components(separatedBy: "T")
        let endDate = (evaluationCollab[indexPath.row].startDate).components(separatedBy: "T")
        cell.libelleCompagneLabel.text = (evaluationCollab[indexPath.row].label)
        cell.startDateLabel.text = startDates[0]
        cell.endDateLabel.text = endDate[0]
        cell.numberOfEvaluators.text = String(evaluationCollab[indexPath.row].participants.count)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "Evaluation", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "evalCollabDetails") as! EvaluationCollaborateurDetailsViewController
                vc.content = evaluationCollab[indexPath.row]
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(vc,animated: false)
                }
        UserDefaults.standard.set(evaluationCollab[indexPath.row].code, forKey: "codeEvaluation")
        }
//    MARK:- Getting data from API
    func displayData(response : EvaluationResponse){
        evaluationCollab = response.content
        table.reloadData()
    }
}
