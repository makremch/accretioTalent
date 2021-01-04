//
//  Population.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 8/1/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import Foundation



// MARK: - PopulationElement
struct PopulationElement: Codable {
    let id: JSONNull?
    let registrationNumber, firstName, lastName: String?
    let status: Status?
    let firstHiringDate: JSONNull?
    let lastHiringDate: String?
    let workCycle: JSONNull?
    let calender: String?
    let firstWeekCycle: JSONNull?
    let affectation: Affectation?
    let manager: JSONNull?
    let profilePicture: String?
    let site, company, payRollNumber, employeeWorkCycle: JSONNull?
    let employeeCalendar: EmployeeCalendar?
//    let employeeWorkCycles: JSONNull?
}


// MARK: - ParentEntity
struct ParentEntity: Codable {
    let id, parentEntityStartDate, parentEntityEndDate: JSONNull?
    let parentEntity: String?
}

// MARK: - EmployeeCalendar
struct EmployeeCalendar: Codable {
    let effectiveDate, code: String?
}


typealias Population = [PopulationElement]
