//
//  FormationInteractor.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 4/27/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol FormationBusinessLogic
{
    func doSomething(request: Formation.Something.Request)
    func getListFormationForValidation(token : String )
    func showListFormationManagerMesDemandes(token : String)
    func showMyActions(token : String)
    func showCatalogueFormation(token : String)
}

protocol FormationDataStore
{
    //var name: String { get set }
}

class FormationInteractor: FormationBusinessLogic, FormationDataStore
{
    var presenter: FormationPresentationLogic?
    var worker: FormationWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Formation.Something.Request)
    {
        worker = FormationWorker()
        worker?.doSomeWork()
        
        let response = Formation.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
    func getListFormationForValidation(token : String ) {
        worker = FormationWorker()
        worker?.getListFormation(token: token).then() {
            formationResponse in
            print("in Interactor Formation : ***************************")
            print(formationResponse)
            print("***********************************************************")
            self.presenter?.showFormationForValidation(response: formationResponse)
        }.catch {error in
            print(error)
            //            self.presenter?.presentSignInError(error: error)
        }
    }
    
    
    func showListFormationManagerMesDemandes(token : String){
        worker = FormationWorker()
        worker?.getListFormationMesDemandes(token: token).then(){
            formationValidation in
            print("in Interactor formation mes demandes ***********************")
            print(formationValidation)
            self.presenter?.showFormationMyDemandes(response: formationValidation)
        }.catch{
            error in
            print(error)
        }
    }
    
    
    func showMyActions(token : String){
        worker = FormationWorker()
        worker?.showMyActions(token: token).then(){
            formationSeesionAction in
            print("in Interactor formation mes actions ***********************")
            print(formationSeesionAction)
            self.presenter?.showMyActions(response: formationSeesionAction)
        }.catch{
            error in
            print(error)
        }
    }
    
    
    func showCatalogueFormation(token : String){
        worker = FormationWorker()
        worker?.showCatalogueFormation(token: token).then(){
            formationCatalogue in
            print("in interractor formation Catalogue **************************")
            print(formationCatalogue)
            self.presenter?.showCatalogue(response : formationCatalogue)
        }.catch{
            error in
            print(error)
        }
    }
    
    
}
