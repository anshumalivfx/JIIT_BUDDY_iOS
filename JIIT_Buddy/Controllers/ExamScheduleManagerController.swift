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
//    let headers = [
//        "Accept": "application/json",
//        "Authorization": "Bearer \(token)",
//        "Content-Type": "application/json",
//        "Host": "webportal.jiit.ac.in:6011",
//        "Origin": "https://webportal.jiit.ac.in:6011",
//    ]
    
    response.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    response.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36 Edg/117.0.0.0", forHTTPHeaderField: "User-Agent")
    response.setValue("\"Microsoft Edge\";v=\"117\", \"Not;A=Brand\";v=\"8\", \"Chromium\";v=\"117\"", forHTTPHeaderField: "sec-ch-ua")
    response.setValue("?0", forHTTPHeaderField: "sec-ch-ua-mobile")
    response.setValue("macOS", forHTTPHeaderField: "sec-ch-ua-platform")
    response.setValue("application/json", forHTTPHeaderField: "Content-Type")
    response.setValue("application/json, text/plain, */*", forHTTPHeaderField: "Accept")
    response.setValue("https://webportal.jiit.ac.in:6011/studentportal/", forHTTPHeaderField: "Referer")
    response.setValue("https://webportal.jiit.ac.in:6011", forHTTPHeaderField: "Origin")
    
    response.httpMethod = "POST"
//    response.allHTTPHeaderFields = headers
    
    
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
