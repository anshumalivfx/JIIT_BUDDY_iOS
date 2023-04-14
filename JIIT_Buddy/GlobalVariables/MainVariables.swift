//
//  File.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 11/04/23.
//

import Foundation
import SwiftUI



var personalInfo: PersonalInfoResponse?


import SwiftUI

// MARK: Colors
let darkBlack = Color(red: 17/255, green: 18/255, blue: 19/255)
let darkGray = Color(red: 41/255, green: 42/255, blue: 48/255)
let darkBlue = Color(red: 96/255, green: 174/255, blue: 201/255)
let darkPink = Color(red: 244/255, green: 132/255, blue: 177/255)
let darkViolet = Color(red: 214/255, green: 189/255, blue: 251/255)
let darkGreen = Color(red: 137/255, green: 192/255, blue: 180/255)

let clearWhite = Color(red: 17/255, green: 18/255, blue: 19/255)
let clearGray = Color(red: 181/255, green: 182/255, blue: 183/255)
let clearBlue = Color(red: 116/255, green: 166/255, blue: 240/255)


var token: String?
var memberid: String?
var clientid: String?

  
    
func convertNtageToDouble(_ ntage: Ntage) -> Double {
    switch ntage {
    case .double(let doubleValue):
        return doubleValue
    case .string:
        return Double(0)
    }
}

enum MyError: Error {
    case invalidConversion
}

func convertNtageToString(_ ntage: Ntage) -> String {
    switch ntage {
    case .double(let doubleValue):
        return String(doubleValue)
    case .string(let stringValue):
        return stringValue
    }
}


func convertToInteger(_ value: Ltotalclass) -> Int {
    switch value {
    case .integer(let intValue):
        return intValue
    case .string:
        return 0
    }
}
