//
//  GradeCardManager.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 15/04/23.
//

import Foundation



func getGradeCard(token: String, studentid: String, instituteid:String, registrationid: String, branchid: String, programid: String, completion: @escaping (Result<GradeCardRequest, Error>) -> Void) {
    let url = URL(string: "https://webportal.jiit.ac.in:6011/StudentPortalAPI/studentgradecard/showstudentgradecard")!
    var request = URLRequest(url: url)
//    let headers = [
//        "Accept": "application/json",
//        "Authorization": "Bearer \(token)",
//        "Content-Type": "application/json",
//        "Host": "webportal.jiit.ac.in:6011",
//        "Origin": "https://webportal.jiit.ac.in:6011",
//        "User-Agent": "Thunder Client (https://www.thunderclient.com)"
//    ]
    request.httpMethod = "POST"
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36 Edg/117.0.0.0", forHTTPHeaderField: "User-Agent")
    request.setValue("\"Microsoft Edge\";v=\"117\", \"Not;A=Brand\";v=\"8\", \"Chromium\";v=\"117\"", forHTTPHeaderField: "sec-ch-ua")
    request.setValue("?0", forHTTPHeaderField: "sec-ch-ua-mobile")
    request.setValue("macOS", forHTTPHeaderField: "sec-ch-ua-platform")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json, text/plain, */*", forHTTPHeaderField: "Accept")
    request.setValue("https://webportal.jiit.ac.in:6011/studentportal/", forHTTPHeaderField: "Referer")
    request.setValue("https://webportal.jiit.ac.in:6011", forHTTPHeaderField: "Origin")
//    request.allHTTPHeaderFields = headers
    
    
    
    let payload: [String: Any] = [
        "instituteid": instituteid,
         "studentid": studentid,
         "registrationid": registrationid,
         "branchid": branchid,
         "programid": programid
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
            let apiResponse = try decoder.decode(GradeCardRequest.self, from: data)
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
