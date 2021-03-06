//
//  EvaluationManagerInteractor.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/22/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol EvaluationManagerBusinessLogic
{
    func doSomething(request: EvaluationManager.Something.Request)
    func showEvaluationsManager(token : String)
}

protocol EvaluationManagerDataStore
{
    //var name: String { get set }
}

class EvaluationManagerInteractor: EvaluationManagerBusinessLogic, EvaluationManagerDataStore
{
    var presenter: EvaluationManagerPresentationLogic?
    var worker: EvaluationManagerWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: EvaluationManager.Something.Request)
    {
        worker = EvaluationManagerWorker()
        worker?.doSomeWork()
        
        let response = EvaluationManager.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
    
    func showEvaluationsManager(token : String) {
        worker = EvaluationManagerWorker()
        worker?.showManagerEvaluations(token: token).then(){
            evaluationManager in
            print(evaluationManager)
            print("eval manager interactor ! ")
            self.presenter?.showEvaluationManager(responses: evaluationManager)
        }.catch{
            error in
            print(error)
        }
    }
}
