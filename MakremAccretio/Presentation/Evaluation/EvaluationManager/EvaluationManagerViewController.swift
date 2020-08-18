//
//  EvaluationManagerViewController.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/22/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol EvaluationManagerDisplayLogic: class
{
    func displaySomething(viewModel: EvaluationManager.Something.ViewModel)
    func displayDataManager(response : EvaluationManagerResponse)
}

class EvaluationManagerViewController: UIViewController, EvaluationManagerDisplayLogic
{
    var interactor: EvaluationManagerBusinessLogic?
    var router: (NSObjectProtocol & EvaluationManagerRoutingLogic & EvaluationManagerDataPassing)?
    var managerData : [ManagerEvaluation] = []
    
    
    //    MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
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
        let interactor = EvaluationManagerInteractor()
        let presenter = EvaluationManagerPresenter()
        let router = EvaluationManagerRouter()
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
        self.interactor?.showEvaluationsManager(token: token)
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: "CompetencesCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "CompetencesCell")
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = EvaluationManager.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: EvaluationManager.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    
    func displayDataManager(response : EvaluationManagerResponse){
        managerData = response.content!
        print(managerData)
        tableView.reloadData()
    }
}


extension EvaluationManagerViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cell = tableView.dequeueReusableCell(withIdentifier: "CompetencesCell", for: indexPath) as? CompetencesCell
            else {
                return UITableViewCell()
        }
        cell.TitreLabel.text = managerData[indexPath.row].label
        cell.descriptionLabel.text = managerData[indexPath.row].contentDescription
        
        let clearedStartDate =  managerData[indexPath.row].startDate!.components(separatedBy: "T")
        let clearedEndDate = managerData[indexPath.row].endDate!.components(separatedBy: "T")
        cell.startDateLabel.text = "Date début: " + clearedStartDate[0]
        cell.endDateLabel.text = "Date fin: " + clearedEndDate[0]
        if managerData[indexPath.row].status == "INP"{
            cell.statusLabel.text = "En cours"
            cell.statusView.layer.cornerRadius = 5
        }else{
            cell.statusLabel.text = "NA"
            cell.statusView.layer.backgroundColor = UIColor.orange.cgColor
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Evaluation", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "evalManagerDetails") as! ManagerEvaluationDetailsViewController
        vc.content = managerData[indexPath.row]
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc,animated: false)
        }
        UserDefaults.standard.set(managerData[indexPath.row].code, forKey: "codeEvalManager")
    }
    
    
}
