//
//  ExamSchedule.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 02/05/23.
//

import Foundation


struct RequestExamSchedule: Codable {
    let response: ExamScheduleResponse
}

struct ExamScheduleResponse: Codable {
    let subjectinfo: [ExamSchedule]
}

struct ExamSchedule: Codable {
    let examDate: String
    let examTime: String
    let subject: String
    let roomNumber: String
    let seatNumber: String
}

