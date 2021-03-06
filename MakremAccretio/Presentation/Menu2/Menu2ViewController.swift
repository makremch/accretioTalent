//
//  Menu2ViewController.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 8/15/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol Menu2DisplayLogic: class
{
    func displaySomething(viewModel: Menu2.Something.ViewModel)
}

class Menu2ViewController: UIViewController, Menu2DisplayLogic
{
    var interactor                   : Menu2BusinessLogic?
    var router                       : (NSObjectProtocol & Menu2RoutingLogic & Menu2DataPassing)?
    @IBOutlet weak var iCarosel      : UICollectionView!
    @IBOutlet weak var userNameLabel : UILabel!
    @IBOutlet weak var postLabel     : UILabel!
    @IBOutlet weak var logoutView    : UIView!
    @IBOutlet weak var logoutPopUp: UIView!
    @IBOutlet weak var okButton: UIButton!
    
    
    
    @IBAction func okOnClick(_ sender: Any) {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        self.navigationController?.popViewController(animated: false)
    }
    
  
    
    @IBAction func cancelLogout(_ sender: Any) {
        logoutView.alpha    = 0
        logoutView.isHidden = true
    }
    
    @IBAction func paramsOnClick(_ sender: Any) {
        logoutView.alpha    = 1
        logoutView.isHidden = false
    }
    
    var images: [UIImage] = [
        UIImage(named: "MobiliteInterneCartoon") ?? UIImage(),
        UIImage(named: "recrutementCartoon")     ?? UIImage(),
        UIImage(named: "FormationCartoon")       ?? UIImage(),
        UIImage(named: "CompetenceCartoon")      ?? UIImage(),
        UIImage(named: "EvaluationCartoon")      ?? UIImage()
    ]
    
    var titles = ["Mobilite Interne","Recrutement","Formation","Competences","Evaluation"]
    // MARK: Object lifecycle
    
    private func desigingPopUpLogout(){
        logoutPopUp.layer.cornerRadius        = 5
        logoutPopUp.backgroundColor           = UIColor.white
        logoutPopUp.layer.shadowColor         = UIColor.systemGray.cgColor
        logoutPopUp.layer.shadowColor         = UIColor.systemGray.cgColor
        logoutPopUp.layer.shadowOpacity       = 1
        logoutPopUp.layer.shadowOffset        = .zero
        logoutPopUp.layer.shadowRadius        = 10
        logoutPopUp.layer.shadowPath          = UIBezierPath(rect: logoutPopUp.bounds).cgPath
        logoutPopUp.layer.shouldRasterize     = true
        logoutPopUp.layer.rasterizationScale  = UIScreen.main.scale
        
        okButton.layer.cornerRadius        = 5
        okButton.layer.shadowColor         = UIColor.systemGray4.cgColor
        okButton.layer.shadowColor         = UIColor.systemGray4.cgColor
        okButton.layer.shadowOpacity       = 1
        okButton.layer.shadowOffset        = .zero
        okButton.layer.shadowRadius        = 10
        okButton.layer.shadowPath          = UIBezierPath(rect: okButton.bounds).cgPath
        okButton.layer.shouldRasterize     = true
        okButton.layer.rasterizationScale  = UIScreen.main.scale
        
        
        
    }
    
    
    
    
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
        let viewController         = self
        let interactor             = Menu2Interactor()
        let presenter              = Menu2Presenter()
        let router                 = Menu2Router()
        viewController.interactor  = interactor
        viewController.router      = router
        interactor.presenter       = presenter
        presenter.viewController   = viewController
        router.viewController      = viewController
        router.dataStore           = interactor
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
        self.desigingPopUpLogout()
        doSomething()
        setupiCarosel()
        userNameLabel.text = UserDefaults.standard.string(forKey: "nameOfUser")! + " " + UserDefaults.standard.string(forKey: "lastNameOfUser")!
//        let poste = (UserDefaults.standard.string(forKey: "poste")!)
//        print(poste)
        //postLabel.text = poste
        iCarosel.showsHorizontalScrollIndicator = false
        logoutView.alpha = 0
        logoutView.isHidden = true
        
        
    }
    
    // MARK: Do something
    
    func setupiCarosel(){
        iCarosel.register(UINib.init(nibName: "MenuCollection", bundle: nil), forCellWithReuseIdentifier: "MenuCollection")
        
        let floawLayout = UPCarouselFlowLayout()
        floawLayout.itemSize = CGSize(width: iCarosel.frame.size.width/2.5, height: iCarosel.frame.size.height-20)
        floawLayout.scrollDirection = .horizontal
        floawLayout.sideItemScale = 0.5
        floawLayout.sideItemAlpha = 1.0
        floawLayout.spacingMode = .fixed(spacing: 40)
        iCarosel.collectionViewLayout = floawLayout
        
        iCarosel.delegate = self
        iCarosel.dataSource = self
    }
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = Menu2.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Menu2.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
}
extension Menu2ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
           
           func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
               return images.count
           }
           
           func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               let cell = iCarosel.dequeueReusableCell(withReuseIdentifier: "MenuCollection", for: indexPath) as! MenuCollection
               
               cell.imgvWalkthrough.image = images[indexPath.row]
               cell.lblTitle.text = titles[indexPath.row]
               return cell
           }
           
           func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            if indexPath.row == 0 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let mobiliteC = storyBoard.instantiateViewController(withIdentifier: "mobiliteCollaborateurVC") as! MobiliteCollaborateurViewController
                self.navigationController?.pushViewController(mobiliteC, animated: true)
            }else if indexPath.row == 1{
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let mobiliteCC = storyBoard.instantiateViewController(withIdentifier: "mobiliteVC") as! MobiliteViewController
                self.navigationController?.pushViewController(mobiliteCC, animated: true)
            }else if indexPath.row == 2{
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let formationC = storyBoard.instantiateViewController(withIdentifier: "MenuFormation") as! MenuFormationViewController
                formationC.titleScreen = "Formations"
                self.navigationController?.pushViewController(formationC, animated: true)
            }else if indexPath.row == 3{
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                       let comptenceC = storyBoard.instantiateViewController(withIdentifier: "MenuFormation") as! MenuFormationViewController
                       comptenceC.titleScreen = "Competences"
                       self.navigationController?.pushViewController(comptenceC, animated: true)
            }else {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Evaluation", bundle: nil)
                let evaluationC = storyBoard.instantiateViewController(withIdentifier: "MenuEval") as! menuEvalViewController
                self.navigationController?.pushViewController(evaluationC, animated: true)
            }
                  print("itm selected == \(indexPath.row)")
            
               
            }
              
}
