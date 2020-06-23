//
//  FormationCollaborateurPresenter.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 5/8/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol FormationCollaborateurPresentationLogic
{
    func presentSomething(response: FormationCollaborateur.Something.Response)
    func sendDataFormationCollaborateur(response:ResponseFormationCollaborateur)
}

class FormationCollaborateurPresenter: FormationCollaborateurPresentationLogic
{
    
    
    weak var viewController: FormationCollaborateurDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: FormationCollaborateur.Something.Response)
    {
        let viewModel = FormationCollaborateur.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func sendDataFormationCollaborateur(response: ResponseFormationCollaborateur) {
        viewController?.getData(response:response)
    }
}