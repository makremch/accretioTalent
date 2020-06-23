//
//  FormationMyActionInteractor.swift
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

protocol FormationMyActionBusinessLogic
{
  func doSomething(request: FormationMyAction.Something.Request)
    func showMyActions(token : String)
}

protocol FormationMyActionDataStore
{
  //var name: String { get set }
}

class FormationMyActionInteractor: FormationMyActionBusinessLogic, FormationMyActionDataStore
{
  var presenter: FormationMyActionPresentationLogic?
  var worker: FormationMyActionWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: FormationMyAction.Something.Request)
  {
    worker = FormationMyActionWorker()
    worker?.doSomeWork()
    
    let response = FormationMyAction.Something.Response()
    presenter?.presentSomething(response: response)
  }
    
    
    func showMyActions(token : String){
        worker = FormationMyActionWorker()
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
    
    
}