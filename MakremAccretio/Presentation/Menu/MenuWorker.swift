//
//  MenuWorker.swift
//  MakremAccretio
//
//  Created by Makrem on 3/31/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

class MenuWorker {

    // MARK: - Properties

    typealias Models = MenuModels

    // MARK: - Methods

    // MARK: Screen Specific Validation

    func validate(exampleVariable: String?) -> Models.MenuError? {
        var error: Models.MenuError?

        if exampleVariable?.isEmpty == false {
            error = nil
        } else {
            error = Models.MenuError(type: .emptyExampleVariable)
        }

        return error
    }
}
