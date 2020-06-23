//
//  CatalogueFormationDetailsInteractor.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 5/17/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Promise
import Foundation

protocol CatalogueFormationDetailsBusinessLogic
{
    func doSomething(request: CatalogueFormationDetails.Something.Request)
    func gettingFormationCatalogueById(token: String, code : String)
    
    
}

protocol CatalogueFormationDetailsDataStore
{
    //var name: String { get set }
}

class CatalogueFormationDetailsInteractor: CatalogueFormationDetailsBusinessLogic, CatalogueFormationDetailsDataStore
{
    func gettingFormationCatalogueById(token: String, code: String)  {
        worker = CatalogueFormationDetailsWorker()
        worker?.gettingFormationCatalogueById(token: token, code: code).then(){
            formationCatalogueDetails in
            print("in interractor formation Catalogue **************************")
            print(formationCatalogueDetails)
            self.presenter?.showCatalogueById(response : formationCatalogueDetails)
        }.catch{
            error in
            print(error)
        }
    }
    
    
    
    var presenter: CatalogueFormationDetailsPresentationLogic?
    var worker: CatalogueFormationDetailsWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: CatalogueFormationDetails.Something.Request)
    {
        worker = CatalogueFormationDetailsWorker()
        worker?.doSomeWork()
        
        let response = CatalogueFormationDetails.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
    
    
    
}