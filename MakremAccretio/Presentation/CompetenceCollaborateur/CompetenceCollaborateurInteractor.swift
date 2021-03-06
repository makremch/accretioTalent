//
//  CompetenceCollaborateurInteractor.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 6/2/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Promise

protocol CompetenceCollaborateurBusinessLogic
{
    func doSomething(request: CompetenceCollaborateur.Something.Request)
    func getCompetence(token : String )
}

protocol CompetenceCollaborateurDataStore
{
    //var name: String { get set }
}

class CompetenceCollaborateurInteractor: CompetenceCollaborateurBusinessLogic, CompetenceCollaborateurDataStore
{
    var presenter: CompetenceCollaborateurPresentationLogic?
    var worker: CompetenceCollaborateurWorker?
    //var name: String = ""
    
    // MARK: Do something
    func doSomething(request: CompetenceCollaborateur.Something.Request)
    {
        worker = CompetenceCollaborateurWorker()
        worker?.doSomeWork()
        
        let response = CompetenceCollaborateur.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
    
    // MARK: - Afficher Competence Collaborateur
    func getCompetence(token : String ) {
        worker = CompetenceCollaborateurWorker()
        worker?.getCompetenceCollaborateur(token: token).then() {
            competenceCollaborateurResponse in
            print("Interactor getlistMobility collaborateur")
            print(competenceCollaborateurResponse)
            self.worker?.getCompetenceLabelCollaborateur(token: token).then(){
                competenceLabelCollaborateurResponse in
                    print("in Interactor getlistLabelCompetence collabb : *************************** count")
                    print(competenceLabelCollaborateurResponse)
                var skillsLabel: [String: String] = [:]

                for competence in competenceLabelCollaborateurResponse {
                    skillsLabel[competence.code!] = competence.label
                }
                self.presenter?.showCompetenceCollaborator(responses: competenceCollaborateurResponse,skillsLabel: skillsLabel)
                }.catch {
                    error in
                    print(error)
                }
        }.catch {error in
            print(error)
        }
    }
}
