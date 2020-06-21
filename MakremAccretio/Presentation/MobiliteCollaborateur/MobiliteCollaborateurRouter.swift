//
//  MobiliteCollaborateurRouter.swift
//  MakremAccretio
//
//  Created by Makrem on 3/2/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol MobiliteCollaborateurRoutingLogic {
    func routeToNext()
}

protocol MobiliteCollaborateurDataPassing {
    var dataStore: MobiliteCollaborateurDataStore? { get }
}

class MobiliteCollaborateurRouter: NSObject, MobiliteCollaborateurRoutingLogic, MobiliteCollaborateurDataPassing {

    // MARK: - Properties

    weak var viewController: MobiliteCollaborateurViewController?
    var dataStore: MobiliteCollaborateurDataStore?

    // MARK: - Routing

    func routeToNext() {
        // let destinationVC = UIStoryboard(name: "", bundle: nil).instantiateViewController(withIdentifier: "") as! NextViewController
        // var destinationDS = destinationVC.router!.dataStore!
        // passDataTo(destinationDS, from: dataStore!)
        // viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    // MARK: - Data Passing

    // func passDataTo(_ destinationDS: inout NextDataStore, from sourceDS: MobiliteCollaborateurDataStore) {
    //     destinationDS.attribute = sourceDS.attribute
    // }
}
