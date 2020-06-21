//
//  DetailsMobiliteRouter.swift
//  MakremAccretio
//
//  Created by Makrem on 2/24/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol DetailsMobiliteRoutingLogic {
    func routeToNext()
}

protocol DetailsMobiliteDataPassing {
    var dataStore: DetailsMobiliteDataStore? { get }
}

class DetailsMobiliteRouter: NSObject, DetailsMobiliteRoutingLogic, DetailsMobiliteDataPassing {

    // MARK: - Properties

    weak var viewController: DetailsMobiliteViewController?
    var dataStore: DetailsMobiliteDataStore?

    // MARK: - Routing

    func routeToNext() {
        // let destinationVC = UIStoryboard(name: "", bundle: nil).instantiateViewController(withIdentifier: "") as! NextViewController
        // var destinationDS = destinationVC.router!.dataStore!
        // passDataTo(destinationDS, from: dataStore!)
        // viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    // MARK: - Data Passing

    // func passDataTo(_ destinationDS: inout NextDataStore, from sourceDS: DetailsMobiliteDataStore) {
    //     destinationDS.attribute = sourceDS.attribute
    // }
}
