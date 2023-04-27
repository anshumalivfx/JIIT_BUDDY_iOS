//
//  StudentAttendance.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 12/04/23.
//

import Foundation


struct AttResponse: Decodable {
    let status: AttStatus
    let response: Payload
}

struct AttStatus: Decodable {
    let responseStatus: String
    let errors: String?
    let identifier: String?
}

struct Payload: Decodable {
    let headerlist: [Header]
    let semlist: [Semester]
}

struct Header: Decodable {
    let branchdesc: String
    let name: String
    let programdesc: String
    let stynumber: String
}

struct Semester: Decodable {
    let registrationcode: String
    let registrationid: String
}

struct AttendanceAPIRequest: Encodable {
    let clientid: String = "JAYPEE"
    let instituteid: String
    let studentid: String
    let stynumber: String
    let registrationid: String
}

struct AttendanceAPIResponse: Codable {
    let status: AttendanceStatus
    let response: AttendanceResponse
}

// MARK: - Response
struct AttendanceResponse: Codable {
    let studentattendancelist: [Studentattendancelist]
}

// MARK: - Studentattendancelist

// MARK: - Studentattendancelist
struct Studentattendancelist: Codable {
    let lTpercantage, lpercentage: Ntage
    let lsubjectcomponentcode: Lsubjectcomponentcode
    let lsubjectcomponentid: String
    let ltotalclass, ltotalpres: Ltotalclass
    let ppercentage: Ntage
    let psubjectcomponentcode: Psubjectcomponentcode
    let psubjectcomponentid: String
    let tpercentage: Ntage
    let tsubjectcomponentcode: Tsubjectcomponentcode
    let tsubjectcomponentid: String
    let ttotalclass, ttotalpres: Ltotalclass
    let abseent, slno: Int
    let subjectcode, subjectid: String

    enum CodingKeys: String, CodingKey {
        case lTpercantage = "LTpercantage"
        case lpercentage = "Lpercentage"
        case lsubjectcomponentcode = "Lsubjectcomponentcode"
        case lsubjectcomponentid = "Lsubjectcomponentid"
        case ltotalclass = "Ltotalclass"
        case ltotalpres = "Ltotalpres"
        case ppercentage = "Ppercentage"
        case psubjectcomponentcode = "Psubjectcomponentcode"
        case psubjectcomponentid = "Psubjectcomponentid"
        case tpercentage = "Tpercentage"
        case tsubjectcomponentcode = "Tsubjectcomponentcode"
        case tsubjectcomponentid = "Tsubjectcomponentid"
        case ttotalclass = "Ttotalclass"
        case ttotalpres = "Ttotalpres"
        case abseent, slno, subjectcode, subjectid
    }
}

enum Ntage: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Ntage.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Ntage"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Lsubjectcomponentcode: String, Codable {
    case empty = ""
    case l = "L"
}

enum Ltotalclass: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Ltotalclass.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Ltotalclass"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Psubjectcomponentcode: String, Codable {
    case empty = ""
    case p = "P"
}

enum Tsubjectcomponentcode: String, Codable {
    case empty = ""
    case t = "T"
}

// MARK: - Status
struct AttendanceStatus: Codable {
    let responseStatus: String
    let errors, identifier: JSONNull?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
            hasher.combine(0)
        }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}



struct AttendancePercentageDetails: Codable {
    let status: AttendancePercentageStatus
    let response: AttendancePercentageResponse
}

// MARK: - Response
struct AttendancePercentageResponse: Codable {
    let studentAttdsummarylist: [StudentAttdsummarylist]
}

// MARK: - StudentAttdsummarylist
struct StudentAttdsummarylist: Codable {
    let attendanceby: String
    let classtype: Classtype
    let datetime: String
    let present: String
}

enum Classtype: String, Codable {
    case extra = " Extra"
    case regular = "Regular"
}

enum Present: String, Codable {
    case absent = "Absent"
    case present = "Present"
}

// MARK: - Status
struct AttendancePercentageStatus: Codable {
    let responseStatus: String
    let errors, identifier: AttendancePercentageJSONNull?
}

// MARK: - Encode/decode helpers

class AttendancePercentageJSONNull: Codable, Hashable {

    public static func == (lhs: AttendancePercentageJSONNull, rhs: AttendancePercentageJSONNull) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
            hasher.combine(0)
        }


    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(AttendancePercentageJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}



// MARK: - Cmpidkey
struct Cmpidkey: Codable {
    let subjectcomponentid: String
}

