//
//  EvaluationCollaborateurInteractor.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 6/28/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol EvaluationCollaborateurBusinessLogic
{
    func doSomething(request: EvaluationCollaborateur.Something.Request)
    func showEvaluationsCollaborateur(token : String)
}

protocol EvaluationCollaborateurDataStore
{
    //var name: String { get set }
}

class EvaluationCollaborateurInteractor: EvaluationCollaborateurBusinessLogic, EvaluationCollaborateurDataStore
{
    var presenter: EvaluationCollaborateurPresentationLogic?
    var worker: EvaluationCollaborateurWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: EvaluationCollaborateur.Something.Request)
    {
        worker = EvaluationCollaborateurWorker()
        worker?.doSomeWork()
        
        let response = EvaluationCollaborateur.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
    
    func showEvaluationsCollaborateur(token : String) {
        worker = EvaluationCollaborateurWorker()
        worker?.showCollaborateurEvaluations(token: token).then(){
            evaluation in
            self.presenter?.showEvaluationCollaborateur(responses: evaluation)
        }.catch{
            error in
            print(error)
        }
    }
}
