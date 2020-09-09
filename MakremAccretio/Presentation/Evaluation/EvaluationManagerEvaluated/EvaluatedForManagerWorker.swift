//
//  EvaluatedForManagerWorker.swift
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
import Promise


class EvaluatedForManagerWorker
{
    func doSomeWork()
    {
    }
    func showManagerEvaluationsDetails(token : String) -> Promise<EvaluatedResponse> {
        return EvaluationAPI.showEvaluationManagerEvaluated(token: token)
    }
}
