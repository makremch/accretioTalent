//
//  CompanyConfig.swift
//  MakremAccretio
//
//  Created by Makrem on 2/19/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation


struct CompanyConfig  {
    let appName: String
    let clientId: String
    let colorPrimary: String
    let colorPrimaryDark: String
    let colorSecondary: String
    let company: String
    let logo: String
    let logoLight: String?
    let logoSmall: String?
    let url: String
    let appEnabled: Bool
    let messenger_enabled: Bool
    let loginBackground: String
    let hasTimeline: Bool
    let certifEnabled: Bool
    let modules: [AccretioModule]?
    let absence_prefix : String?
    let phone_numbers_visible: Bool?
    var has_qrcode_login: Bool?
    var has_youtubechannel: String?
    var has_vimeochannel: String?
    var has_connect: Bool?
    
}
extension CompanyConfig {
    enum CodingKeys: String, CodingKey {
        case appName = "app_name"
        case clientId = "client_id"
        case colorPrimary = "color_primary"
        case colorPrimaryDark = "color_primary_dark"
        case colorSecondary = "color_secondary"
        case company
        case logo
        case logoLight = "logo_light"
        case logoSmall = "logo_small"
        case url
        case appEnabled = "app_enabled"
        case messenger_enabled = "messenger_enabled"
        case loginBackground = "login_background"
        case hasTimeline = "has_timeline"
        case certifEnabled = "certif_enabled"
        case modules
        case absence_prefix = "absence_prefix"
        case phone_numbers_visible = "phone_numbers_visible"
        case has_qrcode_login = "has_qrcode_login"
        case has_youtubechannel
        case has_vimeochannel
        case has_connect
         
        
    }
}

