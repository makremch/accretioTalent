//
//  EvaluatedForManagerPresenter.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 8/19/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol EvaluatedForManagerPresentationLogic
{
  func presentSomething(response: EvaluatedForManager.Something.Response)
    func showEvaluatedManager(responses: EvaluatedResponse)
}

class EvaluatedForManagerPresenter: EvaluatedForManagerPresentationLogic
{
  weak var viewController: EvaluatedForManagerDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: EvaluatedForManager.Something.Response)
  {
    let viewModel = EvaluatedForManager.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
    
    
    func showEvaluatedManager(responses: EvaluatedResponse){
        viewController?.displayData(response:responses)
    }
}