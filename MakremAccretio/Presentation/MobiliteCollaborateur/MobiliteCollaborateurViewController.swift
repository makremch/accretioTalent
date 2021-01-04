//
//  MobiliteCollaborateurViewController.swift
//  MakremAccretio
//
//  Created by Makrem on 3/2/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit
import Kingfisher

protocol MobiliteCollaborateurDisplayLogic: class {
    func displayFetchFromLocalDataStore(with viewModel: MobiliteCollaborateurModels.FetchFromLocalDataStore.ViewModel)
    func displayFetchFromRemoteDataStore(with viewModel: MobiliteCollaborateurModels.FetchFromRemoteDataStore.ViewModel)
    func displayTrackAnalytics(with viewModel: MobiliteCollaborateurModels.TrackAnalytics.ViewModel)
    func displayPerformMobiliteCollaborateur(with viewModel: MobiliteCollaborateurModels.PerformMobiliteCollaborateur.ViewModel)
    func getDataCollaborator(response: Response)
 
    
}

class MobiliteCollaborateurViewController: UIViewController, MobiliteCollaborateurDisplayLogic {
    
    //    MARK: - Iboutlets:
    @IBOutlet weak var searchBar    : UISearchBar!
    @IBOutlet weak var tableView    : UITableView!
    @IBOutlet var exampleRemoteLabel: UILabel! = UILabel()
    @IBOutlet var exampleLocalLabel : UILabel! = UILabel()
    
    
//    MARK:- Let and var declaration :
    typealias Models                              = MobiliteCollaborateurModels
    let ud                                        = UserDefaults.standard
    var dataValueCollaborateur        : [Content] = []
    var searchActive                  : Bool      = false
    var selectedScopeSearchButton     : Int       = 0
    var currentDataValueCollaborateur : [Content] = []
    let baseURL                       : String    = "https://mobile-int.accretio.io/"
//    let baseURL                     : String    = "https://accretio-2-tnr.advyteam.com/"
    var router                        : (NSObjectProtocol & MobiliteCollaborateurRoutingLogic & MobiliteCollaborateurDataPassing)?
    var interactor                    : MobiliteCollaborateurBusinessLogic?
    
   
   
//    MARK:- Button Actions :
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    
    
    
    
    //    MARK: - Onclick cell row
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mobiliteCollaborateurDetails = segue.destination as? MobiliteCollaborateurDetailsViewController,
            let index = tableView.indexPathForSelectedRow?.row
            else {
                return
        }
        mobiliteCollaborateurDetails.content = currentDataValueCollaborateur[index]
    }
    
   
    
    
  
    
    
    // MARK: - Properties
    
    
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
        let interactor = MobiliteCollaborateurInteractor()
        let presenter = MobiliteCollaborateurPresenter()
        let router = MobiliteCollaborateurRouter()
        
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
        setinngUpSearchBar()
        setupFetchFromLocalDataStore()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let token = ud.string(forKey: "accessToken")!
        self.interactor?.getListMobilityCollaborator(token: token)
        
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
    
    
    func setupFetchFromLocalDataStore() {
        let request = Models.FetchFromLocalDataStore.Request()
        interactor?.fetchFromLocalDataStore(with: request)
    }
    
    func displayFetchFromLocalDataStore(with viewModel: MobiliteCollaborateurModels.FetchFromLocalDataStore.ViewModel) {
        exampleLocalLabel.text = viewModel.exampleTranslation
    }
    
    
    
    // MARK: - Use Case - Fetch From Remote DataStore
    func setupFetchFromRemoteDataStore() {
        let request = Models.FetchFromRemoteDataStore.Request()
        interactor?.fetchFromRemoteDataStore(with: request)
    }
    
    func displayFetchFromRemoteDataStore(with viewModel: MobiliteCollaborateurModels.FetchFromRemoteDataStore.ViewModel) {
        exampleRemoteLabel.text = viewModel.exampleVariable
    }
    
    // MARK: - Use Case - Track Analytics
    @objc
    func trackScreenViewAnalytics() {
        trackAnalytics(event: .screenView)
    }
    
    func trackAnalytics(event: MobiliteCollaborateurModels.AnalyticsEvents) {
        let request = Models.TrackAnalytics.Request(event: event)
        interactor?.trackAnalytics(with: request)
    }
    
    func displayTrackAnalytics(with viewModel: MobiliteCollaborateurModels.TrackAnalytics.ViewModel) {
        // do something after tracking analytics (if needed)
    }
    
    // MARK: - Use Case - MobiliteCollaborateur
    
    func performMobiliteCollaborateur(_ sender: Any) {
        let request = Models.PerformMobiliteCollaborateur.Request(exampleVariable: exampleLocalLabel.text)
        interactor?.performMobiliteCollaborateur(with: request)
    }
    
    func displayPerformMobiliteCollaborateur(with viewModel: MobiliteCollaborateurModels.PerformMobiliteCollaborateur.ViewModel) {
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
    
    
//    MARK:- Getting data from API :
    func getDataCollaborator(response: Response) {
        dataValueCollaborateur = response.content!
        currentDataValueCollaborateur = dataValueCollaborateur
        tableView.reloadData()
    }
    
}



extension MobiliteCollaborateurViewController : UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
//    MARK:- SearchBar :
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentDataValueCollaborateur = dataValueCollaborateur
            tableView.reloadData()
            UIView.transition(with: tableView, duration: 1.0, options: .transitionCurlUp, animations: {self.tableView.reloadData()}, completion: nil)
            return
        }
        currentDataValueCollaborateur = dataValueCollaborateur.filter({r -> Bool in r.publishedLabelOffer!.contains(searchText)})
        tableView.reloadData()
    }
    
    private func setinngUpSearchBar(){
        searchBar.delegate = self
    }
    
    //    MARK: - TableView insert Data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDataValueCollaborateur.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cellCollaborateur = tableView.dequeueReusableCell(withIdentifier: "MobilityCollaborateurTableViewCell", for: indexPath) as?
            MobiliteCollaborateurTableViewCell
            else {
                return UITableViewCell()
        }
        cellCollaborateur.imase.roundImageCorners([.topLeft,.topRight], radius: 10)
            if currentDataValueCollaborateur[indexPath.row].publishedPictureOffer != nil {
                let imageFromUrl = (currentDataValueCollaborateur[indexPath.row].publishedPictureOffer)!
                let urlImage = URL(string: baseURL + "documentsmanagement/api/document-mgm?moduleName=recruitment&codeFile=" + imageFromUrl)
                cellCollaborateur.imase?.kf.setImage(with: urlImage, completionHandler: {
                    result in
                    switch result {
                    case .success:
                        print(result)
                        print("5edmet : ",result)
                        break
                    case .failure:
                        
                        cellCollaborateur.imase?.image = UIImage(named: "noImageAvailable")!
                    }
                })
            }else{
                cellCollaborateur.imase?.image = UIImage(named: "noImageAvailable")!
            }
            cellCollaborateur.offreTitre.text=currentDataValueCollaborateur[indexPath.row].publishedLabelOffer
            cellCollaborateur.codeCollaborateurLabel.text=currentDataValueCollaborateur[indexPath.row].offerCode
//            cellCollaborateur.RegionLabel.text = (dataValueCollaborateur[indexPath.row].publishedLocalisationOffer as Any) as? String
            let test = currentDataValueCollaborateur[indexPath.row]
            if test.publishedLocalisationOffer != [] {
                
                cellCollaborateur.RegionLabel.text = (test.publishedLocalisationOffer?[0])
            }
            if test.publishedContractOffer != [] {
                cellCollaborateur.offreContrat.text = (test.publishedContractOffer?[0])
            }
        return cellCollaborateur
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "detailVC") as! MobiliteCollaborateurDetailsViewController
        vc.content = currentDataValueCollaborateur[indexPath.row]
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc,animated: true)
        }
    }
}
