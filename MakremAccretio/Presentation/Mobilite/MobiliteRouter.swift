//
//  MobiliteRouter.swift
//  MakremAccretio
//
//  Created by Makrem on 2/20/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol MobiliteRoutingLogic {
    func routeToNext()
}

protocol MobiliteDataPassing {
    var dataStore: MobiliteDataStore? { get }
}

class MobiliteRouter: NSObject, MobiliteRoutingLogic, MobiliteDataPassing {

    // MARK: - Properties

    weak var viewController: MobiliteViewController?
    var dataStore: MobiliteDataStore?

    // MARK: - Routing

    func routeToNext() {
        // let destinationVC = UIStoryboard(name: "", bundle: nil).instantiateViewController(withIdentifier: "") as! NextViewController
        // var destinationDS = destinationVC.router!.dataStore!
        // passDataTo(destinationDS, from: dataStore!)
        // viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    // MARK: - Data Passing

    // func passDataTo(_ destinationDS: inout NextDataStore, from sourceDS: MobiliteDataStore) {
    //     destinationDS.attribute = sourceDS.attribute
    // }
}
