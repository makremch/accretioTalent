//
//  createPostulerRouter.swift
//  MakremAccretio
//
//  Created by Makrem on 3/30/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol createPostulerRoutingLogic {
    func routeToNext()
}

protocol createPostulerDataPassing {
    var dataStore: createPostulerDataStore? { get }
}

class createPostulerRouter: NSObject, createPostulerRoutingLogic, createPostulerDataPassing {

    // MARK: - Properties

    weak var viewController: createPostulerViewController?
    var dataStore: createPostulerDataStore?

    // MARK: - Routing

    func routeToNext() {
        // let destinationVC = UIStoryboard(name: "", bundle: nil).instantiateViewController(withIdentifier: "") as! NextViewController
        // var destinationDS = destinationVC.router!.dataStore!
        // passDataTo(destinationDS, from: dataStore!)
        // viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    // MARK: - Data Passing

    // func passDataTo(_ destinationDS: inout NextDataStore, from sourceDS: createPostulerDataStore) {
    //     destinationDS.attribute = sourceDS.attribute
    // }
}
