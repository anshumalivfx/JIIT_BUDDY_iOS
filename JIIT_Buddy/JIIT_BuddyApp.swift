//
//  JIIT_BuddyApp.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 10/04/23.
//

import SwiftUI

@main
struct JIIT_BuddyApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var networkMonitor = NetworkMonitor()
    @StateObject var websiteChecker = WebsiteChecker(url: URL(string: "https://webportal.jiit.ac.in:6011/studentportal/#")!)
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(networkMonitor)
                .environmentObject(websiteChecker)
                .preferredColorScheme(.dark)
        }
    }
    
}
