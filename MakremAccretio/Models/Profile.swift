//
//  Profile.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 11/10/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation


// MARK: - Profile
struct Profile: Codable {
    let id: String
    let addresses: [JSONAny]
//    let  authorCitation: String
//    let citation : String?
    let summary: JSONNull?
    let hobbies: [String]
    let facebook, linkedIn, twitter, firstName: String
    let lastName: String
    let birthDay: JSONNull?
    let businessPhone, email :String
//    let coverPicture, profilePicture: String
    let affectation: Affectation
    let hiringExit: HiringExit
    let registrationNumber, seniorityCompanyPeriod, seniorityGroupPeriod: String
//    let profileSkills: String
//    let languages, firstHiringDate, lastHiringDate: JSONNull?
    let dateAnnivPerso, dateAnnivPersonalized: Bool
}



