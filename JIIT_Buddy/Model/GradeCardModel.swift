//
//  GradeCardModel.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 15/04/23.
//

import Foundation



struct GradeCardRequest: Codable {
    let status: GradeCardStatus?
    let response: GradeCardResponse?
}

// MARK: - Response
struct GradeCardResponse: Codable {
    let gradecard: [Gradecard]
}

// MARK: - Gradecard
struct Gradecard: Codable {
    let branchid, branchcode, gradeid, academicyear: String?
    let cgpapoints, gradepoint: Int?
    let subjectcode, minorsubject, subjectid, subjectdesc: String?
    let stynumber: Int?
    let studentid, programcode: String?
    let earnedcredit: Double?
    let credits: Double?
    let grade, name: String?
    let sgpapoints: Int?
    let enrollmentno: String?
    let coursecreditpoint: Double?
    let pointsecured: Int?
    let programid: String?
}

// MARK: - Status
struct GradeCardStatus: Codable {
    let responseStatus: String?
    let errors, identifier: JSONNull?
}
