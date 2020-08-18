//
//  DetailsManagerEvalDetailsInteractor.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/23/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailsManagerEvalDetailsBusinessLogic
{
    func doSomething(request: DetailsManagerEvalDetails.Something.Request)
    func showEvaluationsManagerDetails(token : String , code : String)
}

protocol DetailsManagerEvalDetailsDataStore
{
    //var name: String { get set }
}

class DetailsManagerEvalDetailsInteractor: DetailsManagerEvalDetailsBusinessLogic, DetailsManagerEvalDetailsDataStore
{
    var presenter: DetailsManagerEvalDetailsPresentationLogic?
    var worker: DetailsManagerEvalDetailsWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: DetailsManagerEvalDetails.Something.Request)
    {
        worker = DetailsManagerEvalDetailsWorker()
        worker?.doSomeWork()
        
        let response = DetailsManagerEvalDetails.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
    func showEvaluationsManagerDetails(token : String , code : String) {
        worker = DetailsManagerEvalDetailsWorker()
        worker?.showManagerEvaluationsDetails(token: token, code: code).then(){
            evaluationManagerDetails in
            self.worker?.showManagerEvaluationsStepsDetails(token: token, id: (evaluationManagerDetails.id)!).then(){
                steps in
                print(steps)
                
                print("wwww")
                self.presenter?.showEvaluationManagerDetails(responses: evaluationManagerDetails, steps : steps)
            }
            print("success !")
            print("eval manager details  interactor ! ")
            
        }.catch{
            error in
            print(error)
        }
    }
    
    
    
}

