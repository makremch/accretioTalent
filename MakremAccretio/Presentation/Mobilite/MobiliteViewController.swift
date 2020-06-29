//
//  MobiliteViewController.swift
//  MakremAccretio
//
//  Created by Makrem on 2/20/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol MobiliteDisplayLogic: class {
    func displayFetchFromLocalDataStore(with viewModel: MobiliteModels.FetchFromLocalDataStore.ViewModel)
    func displayFetchFromRemoteDataStore(with viewModel: MobiliteModels.FetchFromRemoteDataStore.ViewModel)
    func displayTrackAnalytics(with viewModel: MobiliteModels.TrackAnalytics.ViewModel)
    func displayPerformMobilite(with viewModel: MobiliteModels.PerformMobilite.ViewModel)
    func getData(response: DemandeResponse, choix : Int)
    func getDataForValidation(response : DemandeResponse)
    
}

class MobiliteViewController: UIViewController, MobiliteDisplayLogic, UITableViewDataSource,UITableViewDelegate{
    
    
    
    let cellSpacingHeight: CGFloat = 5
    
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet weak var choiceSeg: UISegmentedControl!
    
    
    @IBAction func segmentationForTableView(_ sender: Any) {
        
        let index = choiceSeg.selectedSegmentIndex
        let title = choiceSeg.titleForSegment(at: index)!
        if choiceSeg.selectedSegmentIndex == 0 {
           
            tableView.reloadData()
        } else if title == "A valider" {
            tableView.reloadData()
        }
        tableView.reloadData()
    }
    
    @IBOutlet weak var backtomenu: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    let ud = UserDefaults.standard
    var dataValue : [Demande] = []
    var dataValue2 : [Demande] = []
    
    func getData(response: DemandeResponse, choix : Int) {
        print("response:", response.content.count )
        dataValue = response.content
        tableView.reloadData()
    }
    
    func getDataForValidation(response : DemandeResponse){
        print("response :", response.content.count)
        dataValue2 = response.content
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let index = choiceSeg.selectedSegmentIndex
        if (choiceSeg.titleForSegment(at: index))! == "Mes demandes" {
            
            return dataValue.count
        }
        else  {
            return dataValue2.count
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func dateToString( date: DateFormatter )->String{
        let formatter = date
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        return myStringafd
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cell = tableView.dequeueReusableCell(withIdentifier: "MobilityTableViewCell", for: indexPath) as?
            MobilityTableViewCell
            else {
                return UITableViewCell()
        }
        let index = choiceSeg.selectedSegmentIndex
        if (choiceSeg.titleForSegment(at: index))! == "Mes demandes" {
            cell.codeLabel.text = dataValue[indexPath.row].codeOffer
            cell.libelleLabel.text = dataValue[indexPath.row].labelOffer
            cell.effectifLabel.text = String(dataValue[indexPath.row].numberToCover!)
            cell.dateCreationLabel.text = dataValue[indexPath.row].creationDateOffer!
            if (dataValue[indexPath.row].statusRequest)! == "VALIDATED" {
                cell.statusView.layer.cornerRadius = 2
                cell.statusView.backgroundColor = UIColor.systemGreen
                cell.statusLbael.text = "Validée"
            } else if (dataValue[indexPath.row].statusRequest)! == "INP" {
                cell.statusView.layer.cornerRadius = 2
                cell.statusView.backgroundColor = UIColor.orange
                cell.statusLbael.text = "En cours"
            }
            return cell
        }
        else{
            cell.codeLabel.text = dataValue2[indexPath.row].codeOffer
            cell.libelleLabel.text = dataValue2[indexPath.row].labelOffer
            cell.effectifLabel.text = String(dataValue2[indexPath.row].numberToCover!)
            cell.dateCreationLabel.text = dataValue2[indexPath.row].creationDateOffer!
            if (dataValue2[indexPath.row].statusRequest)! == "VALIDATED" {
                cell.statusView.layer.cornerRadius = 2
                cell.statusView.backgroundColor = UIColor.systemGreen
                cell.statusLbael.text = "Validée"
            } else if (dataValue2[indexPath.row].statusRequest)! == "INP" {
                cell.statusView.layer.cornerRadius = 2
                cell.statusView.backgroundColor = UIColor.orange
                cell.statusLbael.text = "En cours"
            }
            return cell
        }
        
    }
    
    
    
    
    
    
    
    
    
    typealias Models = MobiliteModels
    var router: (NSObjectProtocol & MobiliteRoutingLogic & MobiliteDataPassing)?
    var interactor: MobiliteBusinessLogic?
    
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
        let interactor = MobiliteInteractor()
        let presenter = MobilitePresenter()
        let router = MobiliteRouter()
        
        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.mobiliteViewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        designcell()
        let token = ud.string(forKey: "accessToken")!
        self.interactor?.getListMobility(token: token)
        self.interactor?.getListMobilityForValidation(token: token)
        setupFetchFromLocalDataStore()
        tableView.dataSource = self
        tableView.delegate = self
        self.definesPresentationContext = true
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsMobiliteViewController = segue.destination as? DetailsMobiliteViewController,
            let index = tableView.indexPathForSelectedRow?.row
            else {
                return
        }
        let indexx = choiceSeg.selectedSegmentIndex
        if (choiceSeg.titleForSegment(at: indexx))! == "Mes demandes" {
            detailsMobiliteViewController.demande = dataValue[index]
        }else
        {
            detailsMobiliteViewController.demande = dataValue2[index]
        }
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt demande: Demande) {
        performSegue(withIdentifier: "ident", sender: demande)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DetailsMobiliteViewController") as!
        DetailsMobiliteViewController
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc,animated: true)
        }
    }
    
    
    
    
    
    
    func showComments() {
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        tableView.reloadData()
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
    
    func displayFetchFromLocalDataStore(with viewModel: MobiliteModels.FetchFromLocalDataStore.ViewModel) {
        exampleLocalLabel.text = viewModel.exampleTranslation
    }
    
    // MARK: - Use Case - Fetch From Remote DataStore
    
    @IBOutlet var exampleRemoteLabel: UILabel! = UILabel()
    func setupFetchFromRemoteDataStore() {
        let request = Models.FetchFromRemoteDataStore.Request()
        interactor?.fetchFromRemoteDataStore(with: request)
    }
    
    func displayFetchFromRemoteDataStore(with viewModel: MobiliteModels.FetchFromRemoteDataStore.ViewModel) {
        exampleRemoteLabel.text = viewModel.exampleVariable
    }
    
    // MARK: - Use Case - Track Analytics
    
    @objc
    func trackScreenViewAnalytics() {
        trackAnalytics(event: .screenView)
    }
    
    func trackAnalytics(event: MobiliteModels.AnalyticsEvents) {
        let request = Models.TrackAnalytics.Request(event: event)
        interactor?.trackAnalytics(with: request)
    }
    
    func displayTrackAnalytics(with viewModel: MobiliteModels.TrackAnalytics.ViewModel) {
        // do something after tracking analytics (if needed)
    }
    
    // MARK: - Use Case - Mobilite
    
    func performMobilite(_ sender: Any) {
        let request = Models.PerformMobilite.Request(exampleVariable: exampleLocalLabel.text)
        interactor?.performMobilite(with: request)
    }
    
    func displayPerformMobilite(with viewModel: MobiliteModels.PerformMobilite.ViewModel) {
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



