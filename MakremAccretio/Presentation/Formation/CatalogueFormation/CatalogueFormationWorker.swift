//
//  CatalogueFormationWorker.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 5/12/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Promise

class CatalogueFormationWorker
{
  func doSomeWork()
  {
  }
   
    func showCatalogueFormation(token: String) ->Promise<ResponseCatalogue>{
        print("worker Catalogue !")
        return FormationAPI.showCatalogueFormation(token: token)
    }
    
    
}