//
//  CatalogueFormationInteractor.swift
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

protocol CatalogueFormationBusinessLogic
{
    func doSomething(request: CatalogueFormation.Something.Request)
    func showCatalogueFormation(token : String)
}

protocol CatalogueFormationDataStore
{
    //var name: String { get set }
}

class CatalogueFormationInteractor: CatalogueFormationBusinessLogic, CatalogueFormationDataStore
{
    var presenter: CatalogueFormationPresentationLogic?
    var worker: CatalogueFormationWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: CatalogueFormation.Something.Request)
    {
        worker = CatalogueFormationWorker()
        worker?.doSomeWork()
        
        let response = CatalogueFormation.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
    func showCatalogueFormation(token : String){
        worker = CatalogueFormationWorker()
        worker?.showCatalogueFormation(token: token).then(){
            formationCatalogue in
            print("in interractor formation Catalogue **************************")
            print(formationCatalogue.content[1].picture!)
            print("wwww")
            self.presenter?.showCatalogue(response : formationCatalogue)
        }.catch{
            error in
            print(error)
        }
    }
}
