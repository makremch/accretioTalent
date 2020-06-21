//
//  MobiliteCollaborateurModels.swift
//  MakremAccretio
//
//  Created by Makrem on 3/2/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

enum MobiliteCollaborateurModels {

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

    enum PerformMobiliteCollaborateur {
        struct Request {
            var exampleVariable: String?
        }

        struct Response {
            var error: MobiliteCollaborateurError?
        }

        struct ViewModel {
            var error: MobiliteCollaborateurError?
        }
    }

    // MARK: - Types

    // replace with `AnalyticsEvents` with `AnalyticsConstants` if needed
    typealias AnalyticsEvents = ExampleAnalyticsEvents
    typealias MobiliteCollaborateurError = Error<MobiliteCollaborateurErrorType>

    enum ExampleAnalyticsEvents {
        case screenView
    }

    enum MobiliteCollaborateurErrorType {
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
