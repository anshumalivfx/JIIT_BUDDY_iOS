//
//  AuthManager.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 10/04/23.
//

import Foundation





func signInUser(rollno: String, password: String, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
    // Create URL components and URL
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "webportal.jiit.ac.in"
    urlComponents.port = 6011
    urlComponents.path = "/StudentPortalAPI/token/generate-token1"
    guard let url = urlComponents.url else {
        completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        return
    }

    // Create URL Request
    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    // Add headers
//    request.setValue("application/json, text/plain, */*", forHTTPHeaderField: "Accept")
//    request.setValue("webportal.jiit.ac.in:6011", forHTTPHeaderField: "Host")
//    request.setValue("JIIT_Buddy/1.4.3 (iOS 17.0; iPhone; Scale/3.00)", forHTTPHeaderField: "User-Agent")
//    request.setValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
//    request.setValue("en-US,en;q=0.9", forHTTPHeaderField: "Accept-Language")
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.setValue("https://webportal.jiit.ac.in:6011", forHTTPHeaderField: "Origin")
//    request.setValue("keep-alive", forHTTPHeaderField: "Connection")
//    request.setValue("https://webportal.jiit.ac.in:6011/studentportal/", forHTTPHeaderField: "Referer")
//    request.setValue("empty", forHTTPHeaderField: "Sec-Fetch-Dest")
//    request.setValue("cors", forHTTPHeaderField: "Sec-Fetch-Mode")
//    request.setValue("same-origin", forHTTPHeaderField: "Sec-Fetch-Site")
    
    request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36 Edg/117.0.0.0", forHTTPHeaderField: "User-Agent")
    request.setValue("\"Microsoft Edge\";v=\"117\", \"Not;A=Brand\";v=\"8\", \"Chromium\";v=\"117\"", forHTTPHeaderField: "sec-ch-ua")
    request.setValue("?0", forHTTPHeaderField: "sec-ch-ua-mobile")
    request.setValue("macOS", forHTTPHeaderField: "sec-ch-ua-platform")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json, text/plain, */*", forHTTPHeaderField: "Accept")
    request.setValue("Bearer", forHTTPHeaderField: "Authorization")
    request.setValue("https://webportal.jiit.ac.in:6011/studentportal/", forHTTPHeaderField: "Referer")
    request.setValue("https://webportal.jiit.ac.in:6011", forHTTPHeaderField: "Origin")

    
    

    // Create HTTP Body
    let jsonBody = [
        "username": rollno,
        "passwordotpvalue": password,
        "Modulename": "STUDENTMODULE",
        "otppwd": "PWD"
    ]

    guard let httpBody = try? JSONSerialization.data(withJSONObject: jsonBody, options: []) else {
        completion(.failure(NSError(domain: "Invalid HTTP Body", code: 0, userInfo: nil)))
        return
    }
    request.httpBody = httpBody

    // Create URL Session
    let session = URLSession.shared

    // Create Data Task
    let task = session.dataTask(with: request) { (data, response, error) in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
            return
        }

        guard let data = data else {
            completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
            return
        }

        do {
            // Parse JSON data
            let decoder = JSONDecoder()
            let tokenResponse = try decoder.decode(TokenResponse.self, from: data)
            print(tokenResponse.response.regdata.memberid)
            print(tokenResponse.response.regdata.clientid)
            if tokenResponse.status.responseStatus == "Success" {
                completion(.success(tokenResponse))
            } else {
                completion(.failure(NSError(domain: "Invalid response data", code: 0, userInfo: nil)))
            }
        } catch {
            completion(.failure(error))
        }
    }

    // Start Data Task
    task.resume()
}
