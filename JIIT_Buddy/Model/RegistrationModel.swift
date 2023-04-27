//
//  RegistrationModel.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 15/04/23.
//

import Foundation



// MARK: - StudentResultRequest
struct StudentRegistrationSubjectRequest: Codable {
    let status: StudentRegistrationSubjectStatus
    let response: StudentRegistrationSubjectResponse
}

// MARK: - Response
struct StudentRegistrationSubjectResponse: Codable {
    let registrations: [Registration]
}

// MARK: - Registration
struct Registration: Codable {
    let registrationcode, registrationdesc, registrationid: String
}

// MARK: - Status
struct StudentRegistrationSubjectStatus: Codable {
    let responseStatus: String
    let errors, identifier: StudentRegistrationSubjectJSONNull?
}

// MARK: - Encode/decode helpers

class StudentRegistrationSubjectJSONNull: Codable, Hashable {

    public static func == (lhs: StudentRegistrationSubjectJSONNull, rhs: StudentRegistrationSubjectJSONNull) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
            hasher.combine(0)
        }


    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(StudentRegistrationSubjectJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}



import Foundation

// MARK: - StudentResultRequest
struct StudentSemesterRegistrationRequest: Codable {
    let status: StudentSemesterRegistrationStatus
    let response: StudentSemesterRegistrationResponse
}

// MARK: - Response
struct StudentSemesterRegistrationResponse: Codable {
    let registrations: [RegistrationSubject]
    let totalcreditpoints: Int?
}

// MARK: - Registration
struct RegistrationSubject: Codable {
    let audtsubject: String?
    let credits: Int?
    let employeecode, employeename: String?
    let minorsubject: String?
    let remarks, stytype: String?
    let subjectcode: String?
    let subjectcomponentcode: String?
    let subjectdesc, subjectid: String?
}



// MARK: - Status
struct StudentSemesterRegistrationStatus: Codable {
    let responseStatus: String
    let errors, identifier: StudentSemesterRegistrationJSONNull?
}

// MARK: - Encode/decode helpers

class StudentSemesterRegistrationJSONNull: Codable, Hashable {

    public static func == (lhs: StudentSemesterRegistrationJSONNull, rhs: StudentSemesterRegistrationJSONNull) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
            hasher.combine(0)
        }


    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(StudentSemesterRegistrationJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
