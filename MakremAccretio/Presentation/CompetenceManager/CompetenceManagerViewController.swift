//
//  CompetenceManagerViewController.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 6/21/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CompetenceManagerDisplayLogic: class
{
    func displaySomething(viewModel: CompetenceManager.Something.ViewModel)
    func getDataCompetenceManager(response: CompetenseResponse,skillsLabel:[String: String])
}

class CompetenceManagerViewController: UIViewController, CompetenceManagerDisplayLogic,UITableViewDataSource,UITableViewDelegate
{
    
    
    
    //    MARK:- Var & Let Declarations
    var interactor: CompetenceManagerBusinessLogic?
    var router: (NSObjectProtocol & CompetenceManagerRoutingLogic & CompetenceManagerDataPassing)?
    var response: CompetenseResponse? = nil
    var skillsLabel:[String: String]? = nil
    
    //    MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
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
    
    // MARK: -Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = CompetenceManagerInteractor()
        let presenter = CompetenceManagerPresenter()
        let router = CompetenceManagerRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: -Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View -lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        doSomething()
        let token = UserDefaults.standard.string(forKey: "accessToken")!
        self.interactor?.getListCompetenceManager(token: token)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: -Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = CompetenceManager.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: CompetenceManager.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    
    
    func getDataCompetenceManager(response: CompetenseResponse,skillsLabel:[String: String]){
        self.response = response
        self.skillsLabel = skillsLabel
        print((response.content?.count)!)
        print(response)
        
        self.tableView.reloadData()
    }
    
    var val : String = ""
    
    //    MARK:- Configuring TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.content?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cell = tableView.dequeueReusableCell(withIdentifier: "CompetenceTableViewCell", for: indexPath) as?
                CompetenceTableViewCell
        else {
            return UITableViewCell()
        }
        print(indexPath.row)
        //        cell.CollaborateurNameLabel.text = UserDefaults.standard.string(forKey: "nameOfUser")!
        cell.CollaborateurNameLabel.text = (self.response?.content![indexPath.row].firstName ?? "") + " " +  (self.response?.content![indexPath.row].lastName ?? "")
        
        cell.competence = self.response?.content![indexPath.row]
        cell.skillsLabel = self.skillsLabel
        
        return cell
    }
    
    
    //    MARK:- Back Button
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        print("asssba")
        print(indexPath.item)
        print(indexPath)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "CompetenceCollab") as!
            CompetenceCollaborateurViewController
        vc.response = self.response
        vc.skillsLabel = self.skillsLabel
        vc.index = indexPath.item
        let posteLabel = (self.response?.content![indexPath.item].affectedPosition)!
        print(posteLabel)
        if (self.response?.content![indexPath.item].affectedPosition)! == ""{
            vc.managerPoste = "undefined"
        }else{
            vc.managerPoste = ((self.response?.content![indexPath.item].affectedPosition)! )
        }
        
        vc.nameAndLastNameFromManager = (self.response?.content![indexPath.item].firstName ?? "") + " " +  (self.response?.content![indexPath.item].lastName ?? "")
        val = (self.response?.content![indexPath.row].codeComponent)!
        print(val)
        print("---------------------------------------------------")
        UserDefaults.standard.set(val,forKey:"codeComponent")
        self.navigationController?.pushViewController(vc,animated: true)
    }
    
    
}
