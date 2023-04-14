//
//  UserDataModel.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 11/04/23.
//
import Foundation

struct ResponseStatus: Decodable {
    let responseStatus: String
    let errors: [String]?
    let identifier: String?
}

struct Qualification: Decodable {
    let division: Int
    let fullmarks: Int
    let qualificationcode: String
    let obtainedmarks: Int
    let yearofpassing: Int
    let grade: String?
    let percentagemarks: Double
    let boardname: String
}

struct GeneralInformation: Decodable {
    let academicyear: String
    let branch: String
    let ccityname: String
    let studentemailid: String
    let paddress1: String
    let paddress2: String
    let paddress3: String?
    let studentname: String
    let pcityname: String
    let batch: String
    let studentpersonalemailid: String
    let programcode: String
    let semester: Int
    let category: String
    let registrationno: String
}

struct PersonalInfoResponse: Decodable {
    let status: ResponseStatus
    let response: PersonalInfo
}

struct PersonalInfo: Decodable {
    let qualification: [Qualification]
    let generalinformation: GeneralInformation
}
