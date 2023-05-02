//
//  ExamScheduleManagerController.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 02/05/23.
//

import Foundation




func requestExamSchedule(token: String, memberid: String, instituteid: String, exameventid: String, registrationid: String, completion: @escaping (Result<RequestExamSchedule, Error>) -> Void){
    let url = URL(string: "https://webportal.jiit.ac.in:6011/StudentPortalAPI/studentsttattview/getstudent-examschedule")!
    var response = URLRequest(url: url)
    let headers = [
        "Accept": "application/json",
        "Authorization": "Bearer \(token)",
        "Content-Type": "application/json",
        "Host": "webportal.jiit.ac.in:6011",
        "Origin": "https://webportal.jiit.ac.in:6011",
    ]
    
    response.httpMethod = "POST"
    response.allHTTPHeaderFields = headers
    
    
    let payload: [String: Any] = [
        //        "instituteid": instituteid,
        //        "registrationid": registrationid,
        "memberid":memberid,
        "instituteid":instituteid,
        "exameventid":exameventid,
        "registrationid":registrationid
    ]
    
    let payloadData = try! JSONSerialization.data(withJSONObject: payload)
    
    response.httpBody = payloadData
    
    let task = URLSession.shared.dataTask(with: response) { data, response, error in
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
            let apiResponse = try decoder.decode(RequestExamSchedule.self, from: data)
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
