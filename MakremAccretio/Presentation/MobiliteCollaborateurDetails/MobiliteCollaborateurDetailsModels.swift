//
//  MobiliteCollaborateurDetailsModels.swift
//  MakremAccretio
//
//  Created by Makrem on 3/3/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit

enum MobiliteCollaborateurDetailsModels {

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

    enum PerformMobiliteCollaborateurDetails {
        struct Request {
            var exampleVariable: String?
        }

        struct Response {
            var error: MobiliteCollaborateurDetailsError?
        }

        struct ViewModel {
            var error: MobiliteCollaborateurDetailsError?
        }
    }

    // MARK: - Types

    // replace with `AnalyticsEvents` with `AnalyticsConstants` if needed
    typealias AnalyticsEvents = ExampleAnalyticsEvents
    typealias MobiliteCollaborateurDetailsError = Error<MobiliteCollaborateurDetailsErrorType>

    enum ExampleAnalyticsEvents {
        case screenView
    }

    enum MobiliteCollaborateurDetailsErrorType {
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
