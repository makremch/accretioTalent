//
//  CompanyLoginInteractor.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/5/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CompanyLoginBusinessLogic
{
  func doSomething(request: CompanyLogin.Something.Request)
}

protocol CompanyLoginDataStore
{
  //var name: String { get set }
}

class CompanyLoginInteractor: CompanyLoginBusinessLogic, CompanyLoginDataStore
{
  var presenter: CompanyLoginPresentationLogic?
  var worker: CompanyLoginWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: CompanyLogin.Something.Request)
  {
    worker = CompanyLoginWorker()
    worker?.doSomeWork()
    
    let response = CompanyLogin.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
