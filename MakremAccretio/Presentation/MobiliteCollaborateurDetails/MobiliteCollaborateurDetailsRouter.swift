//
//  MobiliteCollaborateurDetailsRouter.swift
//  MakremAccretio
//
//  Created by Makrem on 3/3/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol MobiliteCollaborateurDetailsRoutingLogic {
    func routeToNext()
}

protocol MobiliteCollaborateurDetailsDataPassing {
    var dataStore: MobiliteCollaborateurDetailsDataStore? { get }
}

class MobiliteCollaborateurDetailsRouter: NSObject, MobiliteCollaborateurDetailsRoutingLogic, MobiliteCollaborateurDetailsDataPassing {

    // MARK: - Properties

    weak var viewController: MobiliteCollaborateurDetailsViewController?
    var dataStore: MobiliteCollaborateurDetailsDataStore?

    // MARK: - Routing

    func routeToNext() {
        
        
        
        // let destinationVC =UIStoryboard(name: "", bundle: nil).instantiateViewController(withIdentifier: "") as! NextViewController
        // var destinationDS = destinationVC.router!.dataStore!
        // passDataTo(destinationDS, from: dataStore!)
        // viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    // MARK: - Data Passing

    // func passDataTo(_ destinationDS: inout NextDataStore, from sourceDS: MobiliteCollaborateurDetailsDataStore) {
    //     destinationDS.attribute = sourceDS.attribute
    // }
}
