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
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")

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
