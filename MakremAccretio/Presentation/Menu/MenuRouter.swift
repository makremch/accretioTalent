//
//  MenuRouter.swift
//  MakremAccretio
//
//  Created by Makrem on 3/31/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol MenuRoutingLogic {
    func routeToNext()
}

protocol MenuDataPassing {
    var dataStore: MenuDataStore? { get }
}

class MenuRouter: NSObject, MenuRoutingLogic, MenuDataPassing {

    // MARK: - Properties

    weak var viewController: MenuViewController?
    var dataStore: MenuDataStore?

    // MARK: - Routing

    func routeToNext() {
        // let destinationVC = UIStoryboard(name: "", bundle: nil).instantiateViewController(withIdentifier: "") as! NextViewController
        // var destinationDS = destinationVC.router!.dataStore!
        // passDataTo(destinationDS, from: dataStore!)
        // viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    // MARK: - Data Passing

    // func passDataTo(_ destinationDS: inout NextDataStore, from sourceDS: MenuDataStore) {
    //     destinationDS.attribute = sourceDS.attribute
    // }
}
