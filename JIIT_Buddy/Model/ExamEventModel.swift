//
//  ExamEventModel.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 15/04/23.
//

import Foundation

struct ExamEventsRequest: Codable {
    let status: ExamEventsStatus?
    let response: ExamEventsResponse?
}

// MARK: ExamEventsRequest convenience initializers and mutators

extension ExamEventsRequest {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ExamEventsRequest.self, from: data)
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
        status: ExamEventsStatus?? = nil,
        response: ExamEventsResponse?? = nil
    ) -> ExamEventsRequest {
        return ExamEventsRequest(
            status: status ?? self.status,
            response: response ?? self.response
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Response
struct ExamEventsResponse: Codable {
    let eventcode: Eventcode?
}

// MARK: Response convenience initializers and mutators

extension ExamEventsResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ExamEventsResponse.self, from: data)
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
        eventcode: Eventcode?? = nil
    ) -> ExamEventsResponse {
        return ExamEventsResponse(
            eventcode: eventcode ?? self.eventcode
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Eventcode
struct Eventcode: Codable {
    let examevent: [Examevent]?
}

// MARK: Eventcode convenience initializers and mutators

extension Eventcode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Eventcode.self, from: data)
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
        examevent: [Examevent]?? = nil
    ) -> Eventcode {
        return Eventcode(
            examevent: examevent ?? self.examevent
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Examevent
struct Examevent: Codable {
    let exameventcode: String?
    let eventfrom: Int?
    let exameventdesc, registrationid, exameventid: String?
}

// MARK: Examevent convenience initializers and mutators

extension Examevent {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Examevent.self, from: data)
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
        exameventcode: String?? = nil,
        eventfrom: Int?? = nil,
        exameventdesc: String?? = nil,
        registrationid: String?? = nil,
        exameventid: String?? = nil
    ) -> Examevent {
        return Examevent(
            exameventcode: exameventcode ?? self.exameventcode,
            eventfrom: eventfrom ?? self.eventfrom,
            exameventdesc: exameventdesc ?? self.exameventdesc,
            registrationid: registrationid ?? self.registrationid,
            exameventid: exameventid ?? self.exameventid
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Status
struct ExamEventsStatus: Codable {
    let responseStatus: String?
    let errors, identifier: String?
}

// MARK: Status convenience initializers and mutators

extension ExamEventsStatus {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ExamEventsStatus.self, from: data)
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
        responseStatus: String?? = nil,
        errors: String?? = nil,
        identifier: String?? = nil
    ) -> Status {
        return Status(
            responseStatus: (responseStatus ?? self.responseStatus) ?? "",
            errors: errors ?? self.errors,
            identifier: identifier ?? self.identifier
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
