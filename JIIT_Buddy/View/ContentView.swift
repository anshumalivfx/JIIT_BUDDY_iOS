//
//  ContentView.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 10/04/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    init() {
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = .clear
        UINavigationBar.appearance().backgroundColor = .clear

        
    }
    @AppStorage("isAuthenticated") var isAuthenticated = false
    @AppStorage("token") var tokenResponse = ""
    @AppStorage("clientid") var clientId = ""
    @AppStorage("memberid") var memberId = ""
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    @EnvironmentObject var websiteChecker: WebsiteChecker
    var body: some View {
        
        if networkMonitor.isConnected {
            if websiteChecker.isWebsiteWorking {
                if isAuthenticated {
                    HomeTabView(memberid: memberId, clientid: clientId, token: tokenResponse)
                } else {
                    VStack {
                        ZStack(alignment: .bottom) {
                            HomeView()
                        }
                    }
                }
            } else {
                WebsiteNotWorking()
            }
            
            
        }
        
        else {
            NoNetworkAccess()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
