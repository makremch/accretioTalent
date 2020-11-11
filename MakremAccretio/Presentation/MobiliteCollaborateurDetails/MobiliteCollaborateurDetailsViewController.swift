//
//  MobiliteCollaborateurDetailsViewController.swift
//  MakremAccretio
//
//  Created by Makrem on 3/3/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit
import MobileCoreServices
import Kingfisher

protocol MobiliteCollaborateurDetailsDisplayLogic: class {
    func displayFetchFromLocalDataStore(with viewModel: MobiliteCollaborateurDetailsModels.FetchFromLocalDataStore.ViewModel)
    func displayFetchFromRemoteDataStore(with viewModel: MobiliteCollaborateurDetailsModels.FetchFromRemoteDataStore.ViewModel)
    func displayTrackAnalytics(with viewModel: MobiliteCollaborateurDetailsModels.TrackAnalytics.ViewModel)
    func displayPerformMobiliteCollaborateurDetails(with viewModel: MobiliteCollaborateurDetailsModels.PerformMobiliteCollaborateurDetails.ViewModel)
    func getCodeViewController(response:CodeCv)
    func hidePostuler(hide:Bool)
    func sucessUpload(response: Content)
}

class MobiliteCollaborateurDetailsViewController: UIViewController, MobiliteCollaborateurDetailsDisplayLogic, UIDocumentPickerDelegate {
    
    
    
    // MARK: - UIDocumentPickerDelegate Methods
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        
    }
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        print("import result : \(myURL)")
        self.choseFile = true
        self.fileUrl = myURL
        self.fileName = myURL.lastPathComponent
        //self.justificatifLabel.text = fileName
        interactor?.postulerMobilite(fileUrl: myURL)
        print(fileName)
    }
    
    func sucessUpload(response: Content) {
        print("view resp !!!!!!!!!!! ")
        print(response)
    }
    
    
    var content : Content?
    @IBOutlet weak var postedByLabel: UILabel!
    @IBOutlet weak var codeOffreLabel: UILabel!
    @IBOutlet weak var titreLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var postulerButton: UIButton!
    @IBOutlet weak var viewBlue: UIView!
    @IBOutlet weak var ContratLabel: UILabel!
    @IBOutlet weak var localisationLabel: UILabel!
    @IBOutlet weak var viewWhiteContrat: UIView!
    @IBOutlet weak var viewWhiteLocalisation: UIView!
    @IBOutlet weak var imgOffer: UIImageView!
    @IBOutlet weak var missionTextView: UITextView!
    @IBOutlet weak var postulerOpenPopup: UIButton!
    @IBOutlet weak var blackViewBg: UIView!
    
    @IBOutlet weak var fileButton: UIButton!
    
    
    @IBAction func postulerButtonopening(_ sender: Any) {
        blackViewBg.isHidden = false
        viewBlue.isHidden = false
        viewBlue.layer.cornerRadius = 15
        postulerButton.layer.cornerRadius = 5
        fileButton.layer.cornerRadius = 5
    }
    
    
    
    
    
    var choseFile = false
    var fileUrl: URL?
    var fileName = ""
    @IBOutlet weak var popUpView: UIView!
    
    @IBAction func cancelButton(_ sender: Any) {
        viewBlue.isHidden = true
        blackViewBg.isHidden = true
    }
    
    @IBAction func candidateButton(_ sender: Any) {
//        popUpView.layer.isHidden = true
    }
    
    func designViewBlue(){
        viewBlue.layer.cornerRadius = 15
//        viewWhiteContrat.layer.cornerRadius = 5
//        viewWhiteLocalisation.layer.cornerRadius = 5
//        postulerButton.layer.cornerRadius = 10
//        viewBlue.layer.opacity = 0.81
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func postulerButton(_ sender: Any) {
        let documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: ["public.data"], in: UIDocumentPickerMode.import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(documentPicker, animated: true, completion: nil)
        blackViewBg.isHidden = true
    }
    
    func hidePostuler(hide:Bool){
        postulerButton.isHidden = hide
        popUpView.isHidden = hide
        messageLabel.isHidden = false
        if postulerButton.isHidden {
            messageLabel.isHidden = false
        }
    }
    
    func getCodeViewController(response:CodeCv){
        print(response)
    }
    
    // MARK: - Properties
    
    typealias Models = MobiliteCollaborateurDetailsModels
    var router: (NSObjectProtocol & MobiliteCollaborateurDetailsRoutingLogic & MobiliteCollaborateurDetailsDataPassing)?
    var interactor: MobiliteCollaborateurDetailsBusinessLogic?
    
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
        let interactor = MobiliteCollaborateurDetailsInteractor()
        let presenter = MobiliteCollaborateurDetailsPresenter()
        let router = MobiliteCollaborateurDetailsRouter()
        
        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        
        
    }
    // MARK: - View Lifecycle
//    let baseURL = "https://accretio-2-tnr.advyteam.com/"
    let baseURL : String = "https://mobile-int.accretio.io/"
    override func viewDidLoad() {
        super.viewDidLoad()
        postulerOpenPopup.layer.cornerRadius = 5
        setupFetchFromLocalDataStore()
        designViewBlue()
        blackViewBg.isHidden = true
        let tap = UITapGestureRecognizer(target : self.view,action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
//        messageLabel.isHidden = true
        codeOffreLabel.text = "Référence : " + String((content?.offerCode)!)
        ContratLabel.text = "Contrat : CDD"
        localisationLabel.text = "Ariana"
        print((content?.publishedPictureOffer!)!)
        let url = URL(string: baseURL + "documentsmanagement/api/document-mgm?moduleName=recruitment&codeFile=" + (content?.publishedPictureOffer!)!)
//        let token = UserDefaults.standard.string(forKey: "accessToken")!
        imgOffer.kf.setImage(with: url){
            result in
            switch result {
            case .success:
                print(result)
                break
            case .failure:
                self.imgOffer.image = UIImage(named: "noImageAvailable")!
            }
        }
        imgOffer.layer.cornerRadius = 10
        print((content?.publishedLocalisationOffer)!)
        print("##")
        if content?.publishedLocalisationOffer?.count != 0 {
            localisationLabel.text = String((content?.publishedLocalisationOffer?[0])!)
        }else{
            localisationLabel.text = "non précisé"
        }
        
        titreLabel.text = content?.publishedLabelOffer
        let publishedMissionOfferWithBalise  = (content?.publishedMissionOffer)!
        let publishedMissionWithoutBalises = publishedMissionOfferWithBalise.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        missionTextView.text = publishedMissionWithoutBalises
        //        self.interactor?.getCodeCvCollaborator(token: token, codeOffer: (content?.codeoffre)!)
        if (content?.initiator?.firstName) != nil || (content?.initiator?.lastName) != nil {
            postedByLabel.text = "Publié par : " + (content?.initiator?.firstName)! + " " + (content?.initiator?.lastName)!
        }
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
    
    func displayFetchFromLocalDataStore(with viewModel: MobiliteCollaborateurDetailsModels.FetchFromLocalDataStore.ViewModel) {
        exampleLocalLabel.text = viewModel.exampleTranslation
    }
    
    // MARK: - Use Case - Fetch From Remote DataStore
    
    @IBOutlet var exampleRemoteLabel: UILabel! = UILabel()
    func setupFetchFromRemoteDataStore() {
        let request = Models.FetchFromRemoteDataStore.Request()
        interactor?.fetchFromRemoteDataStore(with: request)
    }
    
    func displayFetchFromRemoteDataStore(with viewModel: MobiliteCollaborateurDetailsModels.FetchFromRemoteDataStore.ViewModel) {
        exampleRemoteLabel.text = viewModel.exampleVariable
    }
    
    // MARK: - Use Case - Track Analytics
    
    @objc
    func trackScreenViewAnalytics() {
        trackAnalytics(event: .screenView)
    }
    
    func trackAnalytics(event: MobiliteCollaborateurDetailsModels.AnalyticsEvents) {
        let request = Models.TrackAnalytics.Request(event: event)
        interactor?.trackAnalytics(with: request)
    }
    
    func displayTrackAnalytics(with viewModel: MobiliteCollaborateurDetailsModels.TrackAnalytics.ViewModel) {
        // do something after tracking analytics (if needed)
    }
    
    // MARK: - Use Case - MobiliteCollaborateurDetails
    
    func performMobiliteCollaborateurDetails(_ sender: Any) {
        let request = Models.PerformMobiliteCollaborateurDetails.Request(exampleVariable: exampleLocalLabel.text)
        interactor?.performMobiliteCollaborateurDetails(with: request)
    }
    
    func displayPerformMobiliteCollaborateurDetails(with viewModel: MobiliteCollaborateurDetailsModels.PerformMobiliteCollaborateurDetails.ViewModel) {
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
