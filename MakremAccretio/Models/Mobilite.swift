//
//  Mobilite.swift
//  MakremAccretio
//
//  Created by Makrem on 2/20/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation

struct Demande: Codable {
    let id:String?
    let processId:String?
    let codeOffer:String?
    let labelOffer:String?
    let creationDateOffer:String?
    let statusRequest:String?
    let initiator:Employee?
    let numberToCover:Int?
    let localisationOffer:[String?]?
    let startDate:String?
    let numberOfCandidatures:String?
    let recruitmentStaff:String?

}


struct DemandeResponse: Codable {
    let content : [Demande]
    let totalElements : Int?
    let last : Bool?
    let totalPages : Int?
    let first : Bool?
    let sort : String?
    let numberOfElements :Int?
    let size :Int?
    let number :Int?
}

