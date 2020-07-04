//
//  CookiesImageDownloaderPlugin.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/4/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Kingfisher
class CookiesImageDownloaderPlugin: ImageDownloadRequestModifier {
    let authToken: String
    let docToken: String
    let bnesDocToken: String?
    init(authToken: String, docToken: String, bnesDocToken: String?) {
        self.authToken = authToken
        self.docToken = docToken
        self.bnesDocToken = bnesDocToken
    }

    func modified(for request: URLRequest) -> URLRequest? {
        var request = request
        request.addValue("Bearer " + authToken, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        request.addValue(GraviteeKeys.DocMangKey.rawValue, forHTTPHeaderField: HTTPHeaderField.gatewayKey.rawValue)
        if let bnesToken: String = bnesDocToken {
            // if ooredoo
            request.addValue(bnesToken, forHTTPHeaderField: HTTPHeaderField.cookie.rawValue )
        } else {
            request.addValue(docToken, forHTTPHeaderField: HTTPHeaderField.cookie.rawValue)
        }
        return request
    }
}
