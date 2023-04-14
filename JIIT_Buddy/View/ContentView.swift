//
//  ContentView.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 10/04/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @AppStorage("isAuthenticated") var isAuthenticated = false
    @AppStorage("token") var tokenResponse = ""
    @AppStorage("clientid") var clientId = ""
    @AppStorage("memberid") var memberId = ""
    var body: some View {
        if isAuthenticated {
            MainPageView(memberid: memberId, clientId: clientId, tokenResponse: tokenResponse)
        } else {
            VStack {
                ZStack(alignment: .bottom) {
                    
                    HomeView()
                }
            }
        }
        
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
