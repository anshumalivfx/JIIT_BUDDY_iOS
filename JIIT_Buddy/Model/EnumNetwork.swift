//
//  EnumNetwork.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 11/04/23.
//

import Foundation


enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(statusCode: Int, message: String?)
    case decodingFailed
    case unknownError
    case nonHTTPResponse
    case httpError(statusCode: Int)
    case missingData
    case serializationError
    case decodingError
}
