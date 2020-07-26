//
//  ManagerEvaluationDetailsWorker.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/23/20.
//  Copyright (c) 2020 Makrem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Promise

class ManagerEvaluationDetailsWorker
{
    func doSomeWork()
    {
    }
    
    func showManagerEvaluationsDetails(token : String , code : String) -> Promise<EvaluationManagerDetailsResponse> {
        return EvaluationAPI.showEvaluationManagerDetails(token:token , code:code)
    }
    
}
