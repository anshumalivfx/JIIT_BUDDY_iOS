//
//  ExamSchedule.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 02/05/23.
//

import Foundation


struct RequestExamSchedule: Codable {
    let status: ExamScheduleStatus?
    let response: ExamScheduleResponse?
}
struct ExamScheduleStatus: Codable {
    let responseStatus: String?
        let errors, identifier: JSONNull?
}

struct ExamScheduleResponse: Codable {
    let subjectinfo: [ExamSchedule]
}

extension ExamScheduleResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ExamScheduleResponse.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        subjectinfo: [ExamSchedule]?? = nil
    ) -> ExamScheduleResponse {
        return ExamScheduleResponse (
            subjectinfo: (subjectinfo ?? self.subjectinfo)!
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

struct ExamSchedule: Codable {
    let datetimeupto, branchcode, dsid, groupwiseds: String?
        let subjectcode, datetimefrom, subjectid, subjectdesc: String?
        let datetime, programcode, groupwiseexclude: String?
        let roomcode, examcode, seatno, status: String?
}

extension ExamSchedule {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ExamSchedule.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        datetimeupto: String?? = nil,
        branchcode: String?? = nil,
        dsid: String?? = nil,
        groupwiseds: String?? = nil,
        subjectcode: String?? = nil,
        datetimefrom: String?? = nil,
        subjectid: String?? = nil,
        subjectdesc: String?? = nil,
        datetime: String?? = nil,
        programcode: String?? = nil,
        groupwiseexclude: String?? = nil,
        roomcode: String?? = nil,
        examcode: String?? = nil,
        seatno: String?? = nil,
        status: String?? = nil
    ) -> ExamSchedule {
        return ExamSchedule(
            datetimeupto: datetimeupto ?? self.datetimeupto,
            branchcode: branchcode ?? self.branchcode,
            dsid: dsid ?? self.dsid,
            groupwiseds: groupwiseds ?? self.groupwiseds,
            subjectcode: subjectcode ?? self.subjectcode,
            datetimefrom: datetimefrom ?? self.datetimefrom,
            subjectid: subjectid ?? self.subjectid,
            subjectdesc: subjectdesc ?? self.subjectdesc,
            datetime: datetime ?? self.datetime,
            programcode: programcode ?? self.programcode,
            groupwiseexclude: groupwiseexclude ?? self.groupwiseexclude,
            roomcode: roomcode ?? self.roomcode,
            examcode: examcode ?? self.examcode,
            seatno: seatno ?? self.seatno,
            status: status ?? self.status
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
