//
//  WebPortalResponseModels.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 11/04/23.
//

import Foundation


// Define Decodable Structs
struct TokenResponse: Decodable {
    let status: Status
    let response: Response
}

struct Status: Decodable {
    let responseStatus: String
    let errors: String?
    let identifier: String?
}

struct Response: Decodable {
    let regdata: RegData
}

struct RegData: Decodable {
    let clientid: String
    let userDOB: String
    let name: String
    let lastvisitdate: String?
    let membertype: String
    let enrollmentno: String
    let userid: String
    let expiredpassword: String
    let institutelist: [Institute]
    let memberid: String
    let token: String
}

struct Institute: Decodable {
    let label: String
    let value: String
}
