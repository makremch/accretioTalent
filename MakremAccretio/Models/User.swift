//
//  User.swift
//  MakremAccretio
//
//  Created by Makrem on 2/19/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation


struct User: Codable {
    let employee: Employee
    let registrationNumber: String
    let motDePasse: String?
    let login: String
    let userLanguage: String?
    let listRoles: [String]
}

