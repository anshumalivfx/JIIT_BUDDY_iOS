//
//  ResultManager.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 15/04/23.
//

import Foundation


func getStudentResult(token: String, studentid: String, stynumber: String, instituteid: String, completion: @escaping (Result<StudentResultRequest, Error>) -> Void) {
    let url = URL(string: "https://webportal.jiit.ac.in:6011/StudentPortalAPI/studentsgpacgpa/getallsemesterdata")!
    var request = URLRequest(url: url)
    let headers = [
        "Accept": "application/json",
        "Authorization": "Bearer \(token)",
        "Content-Type": "application/json",
        "Host": "webportal.jiit.ac.in:6011",
        "Origin": "https://webportal.jiit.ac.in:6011",
        "User-Agent": "Thunder Client (https://www.thunderclient.com)"
    ]
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    
   
    
    let payload: [String: Any] = [
        "instituteid": instituteid,
          "studentid": studentid,
          "stynumber": stynumber
    ]
    let payloadData = try! JSONSerialization.data(withJSONObject: payload)

    request.httpBody = payloadData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            completion(.failure(NSError(domain: "No data returned from server", code: 0, userInfo: nil)))
            return
        }
        
        let decoder = JSONDecoder()
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dataDecodingStrategy = .deferredToData
            let apiResponse = try decoder.decode(StudentResultRequest.self, from: data)
            completion(.success(apiResponse))
            // process data
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
    }
    task.resume()
}