//
//  AjouterCompetencePresenter.swift
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

protocol AjouterCompetencePresentationLogic
{
    func presentSomething(response: AjouterCompetence.Something.Response)
    func showCompetenceManager(skillsLabel:[String: String],skillsClassification : [String:String])
    func showCompetenceLevel(level:LevelResponse)
    func addCompetenceByManager(response : ResponseAddingCompetence)
}

class AjouterCompetencePresenter: AjouterCompetencePresentationLogic
{
    
    
    weak var viewController: AjouterCompetenceDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: AjouterCompetence.Something.Response)
    {
        let viewModel = AjouterCompetence.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func showCompetenceManager(skillsLabel:[String: String], skillsClassification : [String:String] ){
        viewController?.getDataCompetenceManager(skillsLabel: skillsLabel,skillsCompetence : skillsClassification)
    }
    
    func showCompetenceLevel(level:LevelResponse){
        viewController?.getDataLevel(level: level)
    }
    
    func addCompetenceByManager(response : ResponseAddingCompetence) {
        viewController?.getAddingResponse(response: response)
    }
}
