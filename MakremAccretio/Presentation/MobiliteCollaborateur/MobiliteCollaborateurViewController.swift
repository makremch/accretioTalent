//
//  MobiliteCollaborateurViewController.swift
//  MakremAccretio
//
//  Created by Makrem on 3/2/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol MobiliteCollaborateurDisplayLogic: class {
    func displayFetchFromLocalDataStore(with viewModel: MobiliteCollaborateurModels.FetchFromLocalDataStore.ViewModel)
    func displayFetchFromRemoteDataStore(with viewModel: MobiliteCollaborateurModels.FetchFromRemoteDataStore.ViewModel)
    func displayTrackAnalytics(with viewModel: MobiliteCollaborateurModels.TrackAnalytics.ViewModel)
    func displayPerformMobiliteCollaborateur(with viewModel: MobiliteCollaborateurModels.PerformMobiliteCollaborateur.ViewModel)
    func getDataCollaborator(response: Response)
 
    
}

class MobiliteCollaborateurViewController: UIViewController, MobiliteCollaborateurDisplayLogic, UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    
    @IBAction func onClickManagerButton(_ sender: Any) {
//        presentViewController(MobiliteViewController, animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    //    MARK: - DECLARATION UI & var :
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let ud = UserDefaults.standard
    var dataValueCollaborateur : [Content] = []
    var searchActive : Bool = false
    var selectedScopeSearchButton : Int = 0
    
    
    //    MARK: - TableView insert Data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return currentDataValueArray.count
        }
        return dataValueCollaborateur.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cellCollaborateur = tableView.dequeueReusableCell(withIdentifier: "MobilityCollaborateurTableViewCell", for: indexPath) as?
            MobiliteCollaborateurTableViewCell
            else {
                return UITableViewCell()
        }
        if !searchActive{
            print(searchBar.selectedScopeButtonIndex)
            searchActive = false
            cellCollaborateur.offreTitre.text=dataValueCollaborateur[indexPath.row].publishedLabelOffer
            cellCollaborateur.codeCollaborateurLabel.text=dataValueCollaborateur[indexPath.row].codeOffer
//            cellCollaborateur.RegionLabel.text = (dataValueCollaborateur[indexPath.row].publishedLocalisationOffer as Any) as? String
            let test = dataValueCollaborateur[indexPath.row]
            if test.publishedLocalisationOffer != [] {
                 cellCollaborateur.RegionLabel.text = (test.publishedLocalisationOffer[0])
            }
            if test.publishedContractOffer != [] {
                cellCollaborateur.offreContrat.text = (test .publishedContractOffer?[0])
            }
        }
        else if searchActive {
            print(searchBar.scopeButtonTitles)
            let scope = searchBar.selectedScopeButtonIndex
            
            cellCollaborateur.offreTitre.text = currentDataValueArray[indexPath.row].publishedLabelOffer
            cellCollaborateur.codeCollaborateurLabel.text = currentDataValueArray[indexPath.row].codeOffer
//            cellCollaborateur.RegionLabel.text = currentDataValueArray[indexPath.row].publishedLocalisationOffer[0] ?? ""
        }
//        cellCollaborateur.bgImage.layer.cornerRadius = 15
        
        
        return cellCollaborateur
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "detailVC") as! MobiliteCollaborateurDetailsViewController
        if searchActive {
            vc.content = currentDataValueArray[indexPath.row]
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc,animated: false)
            }
        }else {
        
        vc.content = dataValueCollaborateur[indexPath.row]
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc,animated: true)
        }
//                   self.navigationController?.pushViewController(vc, animated: true)
        }
               
        
    }
    
    
    
    
    func getDataCollaborator(response: Response) {
        print("response:", response )
        dataValueCollaborateur = response.content
        tableView.reloadData()
        
        
    }
    
    
    
    
    
    //    MARK: - Onclick cell row
    		
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mobiliteCollaborateurDetails = segue.destination as? MobiliteCollaborateurDetailsViewController,
            let index = tableView.indexPathForSelectedRow?.row
            else {
                return
        }
        mobiliteCollaborateurDetails.content = dataValueCollaborateur[index]
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar){
        searchActive = true
    }
    
    private func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    
    
    
    
    
    
    
    // MARK: - SearchBar
    
    
    
    var currentDataValueArray = [Content]()
    private func setUpSearchBar(){
        currentDataValueArray = dataValueCollaborateur
        searchBar.delegate = self
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard  !searchText.isEmpty else {
            currentDataValueArray = dataValueCollaborateur;
            tableView.reloadData()
            return
        }
        
        if selectedScopeSearchButton == 0 {
            
            print(selectedScopeSearchButton)
            self.findByOfferName(text: searchText)
            tableView.reloadData()
        }else if selectedScopeSearchButton == 1{
            self.findByOfferRegion(text: searchText)
            tableView.reloadData()
        }else if selectedScopeSearchButton == 2{
            self.findByOfferContrat(text: searchText)
            tableView.reloadData()
        }
        
    }
    
    private func findByOfferName(text : String) {
        currentDataValueArray = dataValueCollaborateur.filter({
            data -> Bool in
            return (data.publishedLabelOffer?.contains(text))!
        })
    }
    
    
    private func findByOfferRegion(text : String) {
        currentDataValueArray = dataValueCollaborateur.filter({
            data -> Bool in
            return (data.publishedLocalisationOffer.contains(text))
        })
    }
    
    private func findByOfferContrat(text : String) {
        currentDataValueArray = dataValueCollaborateur.filter({
            data -> Bool in
            return (data.publishedContractOffer?.contains(text))!
        })
    }
    
    
    
    //    MARK: - ScopeBar for search :
    
    private func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) -> Int{
        print("New scope index is now \(selectedScope)")
        selectedScopeSearchButton = selectedScope
        return selectedScopeSearchButton
    }
    
  
    
    
    // MARK: - Properties
    
    typealias Models = MobiliteCollaborateurModels
    var router: (NSObjectProtocol & MobiliteCollaborateurRoutingLogic & MobiliteCollaborateurDataPassing)?
    var interactor: MobiliteCollaborateurBusinessLogic?
    
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
        setupFetchFromLocalDataStore()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let token = ud.string(forKey: "accessToken")!
        
        self.interactor?.getListMobilityCollaborator(token: token)
        
        //        currentDataValueArray = dataValueCollaborateur
        self.setUpSearchBar()
        
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
    
    @IBOutlet var exampleLocalLabel: UILabel! = UILabel()
    func setupFetchFromLocalDataStore() {
        let request = Models.FetchFromLocalDataStore.Request()
        interactor?.fetchFromLocalDataStore(with: request)
    }
    
    func displayFetchFromLocalDataStore(with viewModel: MobiliteCollaborateurModels.FetchFromLocalDataStore.ViewModel) {
        exampleLocalLabel.text = viewModel.exampleTranslation
    }
    
    // MARK: - Use Case - Fetch From Remote DataStore
    
    @IBOutlet var exampleRemoteLabel: UILabel! = UILabel()
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
    
    
    
    
}
