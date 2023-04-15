//
//  EventmarksManagar.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 15/04/23.
//

import Foundation


//
//func getEventMarks(token: String, studentid: String, instituteid: String, registrationid: String, semesterdesc: String){
//    let url = URL(string: "https://webportal.jiit.ac.in:6011/StudentPortalAPI/studentsexamview/printstudent-exammarks/\(studentid)/\(instituteid)/\(registrationid)/\(semesterdesc)")
//}

func getEventMarks(token: String, studentid: String, instituteid: String, registrationid: String, semesterdesc: String, completion: @escaping (Data?, Error?) -> Void) {
    let urlString = "https://webportal.jiit.ac.in:6011/StudentPortalAPI/studentsexamview/printstudent-exammarks/\(studentid)/\(instituteid)/\(registrationid)/\(semesterdesc)"
    guard let url = URL(string: urlString) else {
        completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
        return
    }
    var request = URLRequest(url: url)
    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            completion(nil, error)
            return
        }
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            completion(nil, NSError(domain: "Server Error", code: 0, userInfo: nil))
            return
        }
        guard let data = data else {
            completion(nil, NSError(domain: "No data returned", code: 0, userInfo: nil))
            return
        }
        completion(data, nil)
    }.resume()
}

