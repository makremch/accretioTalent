//
//  LoginRouter.swift
//  MakremAccretio
//
//  Created by Makrem on 2/19/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

protocol LoginRoutingLogic {
    func routeToNext()
    func routeToMenu()
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {

    // MARK: - Properties

    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?

    // MARK: - Routing

    func routeToNext() {
        // let destinationVC = UIStoryboard(name: "", bundle: nil).instantiateViewController(withIdentifier: "") as! NextViewController
        // var destinationDS = destinationVC.router!.dataStore!
        // passDataTo(destinationDS, from: dataStore!)
        // viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    func routeToMenu(){
        print("text")
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let menu = storyBoard.instantiateViewController(withIdentifier: "menuVC") as! MenuViewController
        //          self.present(menu,animated: true)
        viewController?.navigationController?.pushViewController(menu, animated: true)
    }

    // MARK: - Data Passing

    // func passDataTo(_ destinationDS: inout NextDataStore, from sourceDS: LoginDataStore) {
    //     destinationDS.attribute = sourceDS.attribute
    // }
}
