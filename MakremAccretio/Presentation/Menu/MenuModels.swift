//
//  MenuModels.swift
//  MakremAccretio
//
//  Created by Makrem on 3/31/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

enum MenuModels {

    // MARK: - Use Cases

    enum FetchFromLocalDataStore {
        struct Request {
        }

        struct Response {
        }

        struct ViewModel {
            var exampleTranslation: String?
        }
    }

    enum FetchFromRemoteDataStore {
        struct Request {
        }

        struct Response {
            var exampleVariable: String?
        }

        struct ViewModel {
            var exampleVariable: String?
        }
    }

    enum TrackAnalytics {
        struct Request {
            var event: AnalyticsEvents
        }

        struct Response {
        }

        struct ViewModel {
        }
    }

    enum PerformMenu {
        struct Request {
            var exampleVariable: String?
        }

        struct Response {
            var error: MenuError?
        }

        struct ViewModel {
            var error: MenuError?
        }
    }

    // MARK: - Types

    // replace with `AnalyticsEvents` with `AnalyticsConstants` if needed
    typealias AnalyticsEvents = ExampleAnalyticsEvents
    typealias MenuError = Error<MenuErrorType>

    enum ExampleAnalyticsEvents {
        case screenView
    }

    enum MenuErrorType {
        case emptyExampleVariable, networkError
    }

    struct Error<T> {
        var type: T
        var message: String?

        init(type: T) {
            self.type = type
        }
    }
}
