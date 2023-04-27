//
//  Internet.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 15/04/23.
//

import Foundation
import Network
import Combine




//
//class WebsiteChecker: ObservableObject {
//    @Published var isWebsiteWorking = false
//
//    private var cancellable: AnyCancellable?
//
////    init(url: URL) {
////        // Use Combine to check the website
////        cancellable = URLSession.shared
////            .dataTaskPublisher(for: url)
////            .map { _ in true }
////            .catch { _ in Just(false) }
////            .assign(to: \.isWebsiteWorking, on: self)
////    }
//
//    deinit {
//        // Cancel the Combine subscription when the object is deallocated
//        cancellable?.cancel()
//    }
//}




class WebsiteChecker: ObservableObject {
    @Published var isWebsiteWorking = false
    
    private var cancellable: AnyCancellable?
    
    init(url: URL) {
        // Use Combine to check the website
        cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { data, response -> (data: Data, response: HTTPURLResponse) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                return (data: data, response: httpResponse)
            }
            .filter { response -> Bool in
                response.response.statusCode == 200
            }
            .map { _ in true }
            .catch { _ in Just(false) }
            .receive(on: RunLoop.main)
            .assign(to: \.isWebsiteWorking, on: self)
    }
    
    deinit {
        // Cancel the Combine subscription when the object is deallocated
        cancellable?.cancel()
    }
}





class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    
    @Published var isConnected = false
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}

