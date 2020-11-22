//
//  CatalogueFormationDetailsPresenter.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 5/17/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CatalogueFormationDetailsPresentationLogic
{
    func presentSomething(response: CatalogueFormationDetails.Something.Response)
    func showCatalogueById(response : FormationCatalogueDetails)
    func getSkills(response : [String: String])
}

class CatalogueFormationDetailsPresenter: CatalogueFormationDetailsPresentationLogic
{
    weak var viewController: CatalogueFormationDetailsDisplayLogic?
 
    
    
    // MARK: Do something
    
    func presentSomething(response: CatalogueFormationDetails.Something.Response)
    {
        let viewModel = CatalogueFormationDetails.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func showCatalogueById(response: FormationCatalogueDetails) {
        viewController?.getCatalogueDataDetails(response: response)
    }
    
    func getSkills(response:[String: String]){
        viewController?.getSkills(response:response)
    }
}
