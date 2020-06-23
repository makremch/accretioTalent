//
//  CatalogueFormationViewController.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 5/12/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CatalogueFormationDisplayLogic: class
{
    func displaySomething(viewModel: CatalogueFormation.Something.ViewModel)
    func getCatalogueData(response:ResponseCatalogue)
    func handleDismissAll()
}

class CatalogueFormationViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,CatalogueFormationDisplayLogic
{
    
//    MARK:- Var & Let
    var interactor: CatalogueFormationBusinessLogic?
    var router: (NSObjectProtocol & CatalogueFormationRoutingLogic & CatalogueFormationDataPassing)?
    lazy var popUpWindow : PopUpWindow = {
        let view = PopUpWindow()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.delegate = self
        return view
    }()
    
//    MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var TitleOfView: UILabel!
    
//    MARK:- Button actions
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func DemandeHorsCatalogue(_ sender: Any) {
        designingPopUp()
        popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpWindow.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.popUpWindow.alpha = 1
            self.popUpWindow.transform = CGAffineTransform.identity
        }
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
        let interactor = CatalogueFormationInteractor()
        let presenter = CatalogueFormationPresenter()
        let router = CatalogueFormationRouter()
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
        print(token)
        self.interactor?.showCatalogueFormation(token: token)
        view.addSubview(visualEffectView)
        designingEffectView()
        
    }
    
    // MARK: Manipulating TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValueCatalogue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cell = tableView.dequeueReusableCell(withIdentifier: "catalogueCell", for: indexPath) as?
            CatalogueFormationViewCell
            else {
                return UITableViewCell()
        }
        cell.formationNameLabel.text = dataValueCatalogue[indexPath.row].label
        cell.initiatorLabel.text = dataValueCatalogue[indexPath.row].initiator?.firstName
        cell.dateLabel.text = String(dataValueCatalogue[indexPath.row].creationDate!)
        cell.themeLabel.text = dataValueCatalogue[indexPath.row].theme
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "identCatalogue", sender: indexPath)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "CatalogueFormationDetailsViewController") as!
        CatalogueFormationDetailsViewController
//        vc.formationTitleLabel.text! = dataValueCatalogue[indexPath.row].code!
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc,animated: true)
        }
    }
    
    // MARK: Getting Data
    var dataValueCatalogue : [FormationCatalogue] = []
    
    func doSomething()
    {
        let request = CatalogueFormation.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: CatalogueFormation.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    func getCatalogueData(response:ResponseCatalogue){
        print(response)
        dataValueCatalogue = response.content
        tableView.reloadData()
    }
    
    func designingPopUp(){
        view.addSubview(popUpWindow)
        popUpWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -40).isActive = true
        popUpWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUpWindow.heightAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        popUpWindow.widthAnchor.constraint(equalToConstant: view.frame.width-64).isActive = true
    }
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func designingEffectView(){
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
    }
}

extension CatalogueFormationViewController: PopUpDelegate{
    func handleDismissAll() {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.popUpWindow.alpha = 0
            self.popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpWindow.removeFromSuperview()
            print("Did remove pop up window..")
        }
    }
}

extension UIColor {
    static func mainBlue() -> UIColor {
        return UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    }
}
