//
//  EvaluatedForManagerRouter.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 8/19/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol EvaluatedForManagerRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol EvaluatedForManagerDataPassing
{
  var dataStore: EvaluatedForManagerDataStore? { get }
}

class EvaluatedForManagerRouter: NSObject, EvaluatedForManagerRoutingLogic, EvaluatedForManagerDataPassing
{
  weak var viewController: EvaluatedForManagerViewController?
  var dataStore: EvaluatedForManagerDataStore?
  
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
  
  //func navigateToSomewhere(source: EvaluatedForManagerViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: EvaluatedForManagerDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}