//
//  CompetenceCollaborateurRouter.swift
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

@objc protocol CompetenceCollaborateurRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol CompetenceCollaborateurDataPassing
{
  var dataStore: CompetenceCollaborateurDataStore? { get }
}

class CompetenceCollaborateurRouter: NSObject, CompetenceCollaborateurRoutingLogic, CompetenceCollaborateurDataPassing
{
  weak var viewController: CompetenceCollaborateurViewController?
  var dataStore: CompetenceCollaborateurDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: CompetenceCollaborateurViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: CompetenceCollaborateurDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
