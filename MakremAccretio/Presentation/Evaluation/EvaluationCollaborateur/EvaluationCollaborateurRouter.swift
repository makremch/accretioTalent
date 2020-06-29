//
//  EvaluationCollaborateurRouter.swift
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

@objc protocol EvaluationCollaborateurRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol EvaluationCollaborateurDataPassing
{
  var dataStore: EvaluationCollaborateurDataStore? { get }
}

class EvaluationCollaborateurRouter: NSObject, EvaluationCollaborateurRoutingLogic, EvaluationCollaborateurDataPassing
{
  weak var viewController: EvaluationCollaborateurViewController?
  var dataStore: EvaluationCollaborateurDataStore?
  
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
  
  //func navigateToSomewhere(source: EvaluationCollaborateurViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: EvaluationCollaborateurDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
