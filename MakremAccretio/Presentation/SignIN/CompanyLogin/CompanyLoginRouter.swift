//
//  CompanyLoginRouter.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/5/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol CompanyLoginRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol CompanyLoginDataPassing
{
  var dataStore: CompanyLoginDataStore? { get }
}

class CompanyLoginRouter: NSObject, CompanyLoginRoutingLogic, CompanyLoginDataPassing
{
  weak var viewController: CompanyLoginViewController?
  var dataStore: CompanyLoginDataStore?
  
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
  
  //func navigateToSomewhere(source: CompanyLoginViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: CompanyLoginDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
