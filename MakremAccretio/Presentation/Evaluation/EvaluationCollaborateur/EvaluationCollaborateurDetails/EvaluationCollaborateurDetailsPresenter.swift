//
//  EvaluationCollaborateurDetailsPresenter.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/10/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol EvaluationCollaborateurDetailsPresentationLogic
{
    func presentSomething(response: EvaluationCollaborateurDetails.Something.Response)
    func showEvaluationDetailsCollaborateur(responses : EvaluationDetailsResponse)
    func showEvaluationDetailsCardsCollaborateur(responses: [CommunTargetsCard])
    func showEvaluationDetailsCardsCollaborateurError()
}

class EvaluationCollaborateurDetailsPresenter: EvaluationCollaborateurDetailsPresentationLogic
{
    weak var viewController: EvaluationCollaborateurDetailsDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: EvaluationCollaborateurDetails.Something.Response)
    {
        let viewModel = EvaluationCollaborateurDetails.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
    func showEvaluationDetailsCollaborateur(responses : EvaluationDetailsResponse){
        viewController?.displayDetails(responses: responses)
    }
    func showEvaluationDetailsCardsCollaborateur(responses: [CommunTargetsCard]){
        viewController?.displayCards(responses : responses)
    }
    func showEvaluationDetailsCardsCollaborateurError(){
        viewController?.diplayCardsError()
    }
}
