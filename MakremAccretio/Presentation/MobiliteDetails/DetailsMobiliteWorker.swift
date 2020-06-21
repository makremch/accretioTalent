//
//  DetailsMobiliteWorker.swift
//  MakremAccretio
//
//  Created by Makrem on 2/24/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

class DetailsMobiliteWorker {

    // MARK: - Properties

    typealias Models = DetailsMobiliteModels

    // MARK: - Methods

    // MARK: Screen Specific Validation

    func validate(exampleVariable: String?) -> Models.DetailsMobiliteError? {
        var error: Models.DetailsMobiliteError?

        if exampleVariable?.isEmpty == false {
            error = nil
        } else {
            error = Models.DetailsMobiliteError(type: .emptyExampleVariable)
        }

        return error
    }
}
