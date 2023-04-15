//
//  StudentResultModel.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 14/04/23.
//

import Foundation

// MARK: - StudentResultRequest
struct StudentResultRequest: Codable {
    let status: StudentResultStatus
    let response: StudentResultResponse
}

// MARK: - Response
struct StudentResultResponse: Codable {
    let semesterList: [ResultSemesterList]
}

// MARK: - Status
struct StudentResultStatus: Codable {
    let responseStatus: String
    let errors, identifier: StudentResultJSONNull?
}

// MARK: - Encode/decode helpers

class StudentResultJSONNull: Codable, Hashable {

    public static func == (lhs: StudentResultJSONNull, rhs: StudentResultJSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(StudentResultJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


struct ResultSemesterList : Codable, Identifiable {
    let id: String?
    let totalpointsecuredsgpa : Double?
    let totalcoursecredit : Double?
    let totalearnedcredits : Double?
    let totalpointsecuredcgpa : Double?
    let totalearnedcredit : Double?
    let sgpa : Double?
    let stynumber : Double?
    let totalregisteredcredit : Double?
    let prograsivegradepoints : Double?
    let registeredcredit : Double?
    let totalgradepoints : Double?
    let cgpa : Double?
    let prograsivetotalearnedcredit : Double?
    let earnedgradepoints : Double?
    let prograde : Double?

    enum CodingKeys: String, CodingKey {

        case totalpointsecuredsgpa = "totalpointsecuredsgpa"
        case totalcoursecredit = "totalcoursecredit"
        case totalearnedcredits = "totalearnedcredits"
        case totalpointsecuredcgpa = "totalpointsecuredcgpa"
        case totalearnedcredit = "totalearnedcredit"
        case sgpa = "sgpa"
        case stynumber = "stynumber"
        case totalregisteredcredit = "totalregisteredcredit"
        case prograsivegradepoints = "prograsivegradepoints"
        case registeredcredit = "registeredcredit"
        case totalgradepoints = "totalgradepoints"
        case cgpa = "cgpa"
        case prograsivetotalearnedcredit = "prograsivetotalearnedcredit"
        case earnedgradepoints = "earnedgradepoints"
        case prograde = "prograde"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID().uuidString
        totalpointsecuredsgpa = try values.decodeIfPresent(Double.self, forKey: .totalpointsecuredsgpa)
        totalcoursecredit = try values.decodeIfPresent(Double.self, forKey: .totalcoursecredit)
        totalearnedcredits = try values.decodeIfPresent(Double.self, forKey: .totalearnedcredits)
        totalpointsecuredcgpa = try values.decodeIfPresent(Double.self, forKey: .totalpointsecuredcgpa)
        totalearnedcredit = try values.decodeIfPresent(Double.self, forKey: .totalearnedcredit)
        sgpa = try values.decodeIfPresent(Double.self, forKey: .sgpa)
        stynumber = try values.decodeIfPresent(Double.self, forKey: .stynumber)
        totalregisteredcredit = try values.decodeIfPresent(Double.self, forKey: .totalregisteredcredit)
        prograsivegradepoints = try values.decodeIfPresent(Double.self, forKey: .prograsivegradepoints)
        registeredcredit = try values.decodeIfPresent(Double.self, forKey: .registeredcredit)
        totalgradepoints = try values.decodeIfPresent(Double.self, forKey: .totalgradepoints)
        cgpa = try values.decodeIfPresent(Double.self, forKey: .cgpa)
        prograsivetotalearnedcredit = try values.decodeIfPresent(Double.self, forKey: .prograsivetotalearnedcredit)
        earnedgradepoints = try values.decodeIfPresent(Double.self, forKey: .earnedgradepoints)
        prograde = try values.decodeIfPresent(Double.self, forKey: .prograde)
    }

}
