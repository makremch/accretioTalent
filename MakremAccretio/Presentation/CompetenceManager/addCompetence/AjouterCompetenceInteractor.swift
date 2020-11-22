//
//  AjouterCompetenceInteractor.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 11/11/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AjouterCompetenceBusinessLogic
{
    func doSomething(request: AjouterCompetence.Something.Request)
    func getListCompetenceManager(token : String )
    func getListCompetenceLevel(token : String, codeCompetence : String )
    func addCompetenceByManager(token : String, params:[String:Any])
}

protocol AjouterCompetenceDataStore
{
    //var name: String { get set }
}

class AjouterCompetenceInteractor: AjouterCompetenceBusinessLogic, AjouterCompetenceDataStore
{
    
    
    var presenter: AjouterCompetencePresentationLogic?
    var worker: AjouterCompetenceWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: AjouterCompetence.Something.Request)
    {
        worker = AjouterCompetenceWorker()
        worker?.doSomeWork()
        
        let response = AjouterCompetence.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
    func getListCompetenceManager(token : String ) {
        self.worker?.getCompetenceLabelManager(token: token).then(){
            competenceLabelCollaborateurResponse in
            print("in Interactor getlistLabelCompetence manager : *************************** count")
            
            var skillsLabel: [String: String] = [:]
            var skillsClassification: [String: String] = [:]
            for competence in competenceLabelCollaborateurResponse {
                skillsLabel[competence.code!] = competence.label
                skillsClassification[competence.code!] = competence.classification
            }
            self.presenter?.showCompetenceManager(skillsLabel: skillsLabel , skillsClassification: skillsClassification)
        }.catch {
            error in
            print(error)
        }
    }
    
    func getListCompetenceLevel(token : String, codeCompetence : String ) {
        self.worker?.getLevels(token: token, codeClassification: codeCompetence).then(){
            level in
            print(level)
            self.presenter?.showCompetenceLevel(level: level)
        }.catch {
            error in
            print(error)
        }
    }
    
    func addCompetenceByManager(token: String, params: [String : Any]) {
        self.worker?.addCompetenceByManager(token: token, params: params).then(){
            responseCompetenceAdd in
            print(responseCompetenceAdd)
            self.presenter?.addCompetenceByManager(response: responseCompetenceAdd)
        }.catch{
            error in
            print(error)
        }
    }
    
    
    
    
    
}
