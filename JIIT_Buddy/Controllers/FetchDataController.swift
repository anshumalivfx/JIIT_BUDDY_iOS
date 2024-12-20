//
//  FetchDataController.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 11/04/23.
//

import Foundation

func getPersonalInformation(memberId: String, clientId: String, token: String, instituteid: String, completion: @escaping (Result<PersonalInfoResponse, Error>) -> Void) {
    // Set up the request URL
    let urlString = "https://webportal.jiit.ac.in:6011/StudentPortalAPI/studentpersinfo/getstudent-personalinformation"
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        return
    }

    // Set up the request headers
    var request = URLRequest(url: url)
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36 Edg/117.0.0.0", forHTTPHeaderField: "User-Agent")
    request.setValue("\"Microsoft Edge\";v=\"117\", \"Not;A=Brand\";v=\"8\", \"Chromium\";v=\"117\"", forHTTPHeaderField: "sec-ch-ua")
    request.setValue("?0", forHTTPHeaderField: "sec-ch-ua-mobile")
    request.setValue("macOS", forHTTPHeaderField: "sec-ch-ua-platform")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json, text/plain, */*", forHTTPHeaderField: "Accept")
    request.setValue("https://webportal.jiit.ac.in:6011/studentportal/", forHTTPHeaderField: "Referer")
    request.setValue("https://webportal.jiit.ac.in:6011", forHTTPHeaderField: "Origin")
    request.httpMethod = "POST"

    // Set up the request body
    let payload = ["clientid": clientId, "memberid": memberId, "instituteid": instituteid]
    guard let httpBody = try? JSONSerialization.data(withJSONObject: payload, options: []) else {
        completion(.failure(NSError(domain: "Invalid payload", code: 0, userInfo: nil)))
        return
    }
    request.httpBody = httpBody

    // Make the request
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        // Handle errors
        if let error = error {
            completion(.failure(error))
            return
        }

        // Parse the response data
        guard let data = data else {
            completion(.failure(NSError(domain: "No data returned", code: 0, userInfo: nil)))
            return
        }

        do {
            let personalInfoResponse = try JSONDecoder().decode(PersonalInfoResponse.self, from: data)
            
            completion(.success(personalInfoResponse))
        } catch {
            completion(.failure(error))
        }
    }

    task.resume()
}
