//
//  Employee.swift
//  MakremAccretio
//
//  Created by Makrem on 2/19/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation


struct Employee: Codable, Hashable {

    let id: String
    let firstName: String
    let lastName: String
    let profilePicture: String?
    let coverPicture: String?
    let registrationNumber: String
    let status: StatusEmployeeByManager?
    let birthDay: String?
//    let affectation: Affectation?
    let userAccount: String
    let citation: String?
    let authorCitation: String?
    let email: String?
//    let contract: Contract?
    let calendar: String?
    //let roleDetails : [RoleDetails]
    let firstHiringDate: String?
    let lastHiringDate: String?
    let groupSeniorityDate: String?
    let companySeniorityDate: String?
    let workCycle: String?
    let firstWeekCycle: String?
    var businessPhone: String?
    let employeeType : EmployeeType?

    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.registrationNumber == rhs.registrationNumber
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(registrationNumber)
        hasher.combine(id)
    }
}
struct EmployeeAbsence: Codable, Hashable {

    let id: String?
    let firstName: String?
    let lastName: String?
    let profilePicture: String?
    let coverPicture: String?
    let registrationNumber: String?
    let status: StatusEmployeeByManager?
    let birthDay: String?
//    let affectation: Affectation?
    let userAccount: String?
    let citation: String?
    let authorCitation: String?
    let email: String?
//    let contract: Contract?
    let calendar: String?
    //let roleDetails : [RoleDetails]
    let firstHiringDate: String?
    let lastHiringDate: String?
    let groupSeniorityDate: String?
    let companySeniorityDate: String?
    let workCycle: String?
    let firstWeekCycle: String?
    var businessPhone: String?
    let calender: String?
    let company: String?
    //employeeWorkCycles: [{codeFirstWeek: "SemaineT1", effectiveDate: "2019-04-24", code: "C1"},…]
    let manager: String?
    let site: String?
    
    
    static func == (lhs: EmployeeAbsence, rhs: EmployeeAbsence) -> Bool {
        return lhs.registrationNumber == rhs.registrationNumber
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(registrationNumber)
        hasher.combine(id)
    }
}

struct EmployeeType: Codable {

    let id: String?
    let employeeType :String?
    let typeEffectiveDate : String?
}
