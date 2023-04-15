//
//  AttendanceManager.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 12/04/23.
//

import Foundation


func getAttendance(studentId: String, token: String, instituteid: String,completion: @escaping (Result<Payload, Error>) -> Void) {
    guard let url = URL(string: "https://webportal.jiit.ac.in:6011/StudentPortalAPI/StudentClassAttendance/getstudentInforegistrationforattendence") else {
        completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        return
    }
    var request = URLRequest(url: url)

    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("webportal.jiit.ac.in:6011", forHTTPHeaderField: "Host")
    request.setValue("https://webportal.jiit.ac.in:6011", forHTTPHeaderField: "Origin")
    let body = [
        "clientid": "JAYPEE",
        "instituteid": instituteid,
        "studentid": studentId,
        "membertype": "S"
    ]
    guard let jsonData = try? JSONSerialization.data(withJSONObject: body, options: []) else {
        completion(.failure(NSError(domain: "Invalid JSON data", code: 0, userInfo: nil)))
        return
    }
    request.httpBody = jsonData
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (data, response, error) in
        if let error = error {
            completion(.failure(error))
            return
        }
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            completion(.failure(NSError(domain: "Invalid server response", code: 0, userInfo: nil)))
            return
        }
        guard let data = data else {
            completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
            return
        }
        do {
            let response = try JSONDecoder().decode(AttResponse.self, from: data)
            completion(.success(response.response))
        } catch {
            completion(.failure(error))
        }
    }
    task.resume()
}


func getSemesterAttendance(studentid: String, stynumber: String, registrationid: String, token: String, instituteid: String, completionHandler: @escaping (Result<AttendanceAPIResponse, Error>) -> Void) {
    let url = URL(string: "https://webportal.jiit.ac.in:6011/StudentPortalAPI/StudentClassAttendance/getstudentattendancedetail")!
    let headers = [
        "Accept": "application/json",
        "Authorization": "Bearer \(token)",
        "Content-Type": "application/json",
        "Host": "webportal.jiit.ac.in:6011",
        "Origin": "https://webportal.jiit.ac.in:6011",
        "User-Agent": "Thunder Client (https://www.thunderclient.com)"
    ]
    let request = AttendanceAPIRequest(instituteid: instituteid, studentid: studentid, stynumber: stynumber, registrationid: registrationid)
    
    do {
        let jsonData = try JSONEncoder().encode(request)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("hello")
                completionHandler(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(NSError(domain: "HTTPError", code: (response as? HTTPURLResponse)?.statusCode ?? 500, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(NSError(domain: "DataError", code: 500, userInfo: nil)))
                return
            }
            
            
            
            do {
                
                let decoder = JSONDecoder()
                    do {
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        decoder.dataDecodingStrategy = .deferredToData
                        let apiResponse = try decoder.decode(AttendanceAPIResponse.self, from: data)
                        completionHandler(.success(apiResponse))
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
                
                
//                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                                    // Store the JSON response in a variable or property
//                    if let resp = json["response"] as? [String: Any] {
//
//                            completionHandler(.success(resp))
//                    }
//
//                }
                
            } catch let error {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    } catch {
        completionHandler(.failure(error))
    }
}

func getPercentageDetails(token: String, studentid: String, subjectid: String, registrationid: String, instituteid: String, subjectcomponentids: [String], completion: @escaping (Result<AttendancePercentageDetails, Error>) -> Void) {
    let url = URL(string: "https://webportal.jiit.ac.in:6011/StudentPortalAPI/StudentClassAttendance/getstudentsubjectpersentage")!
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
        "clientid": "JAYPEE",
        "instituteid": instituteid,
        "studentid": studentid,
        "subjectid": subjectid,
        "registrationid": registrationid,
        "cmpidkey": subjectcomponentids.map { ["subjectcomponentid": $0] }
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
            let apiResponse = try decoder.decode(AttendancePercentageDetails.self, from: data)
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




