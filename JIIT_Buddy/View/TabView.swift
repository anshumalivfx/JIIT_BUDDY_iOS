//
//  TabView.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 29/04/23.
//

import SwiftUI

struct HomeTabView: View {
    var memberid: String
    var clientid: String
    var token: String
    @State private var isAnimating: Bool = false
    
    init(memberid: String, clientid: String, token: String) {
        self.memberid = memberid
        self.clientid = clientid
        self.token = token
        
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().barTintColor = .black
    }
    var body: some View {
        
        ZStack {
            TabView {
                MainPageView(memberid: memberid, clientId: clientid, tokenResponse: token)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                ZStack {
                    Color.background.ignoresSafeArea(.all)
                    VStack {
                        HStack {
                            Image(systemName: "bubble.left.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
//                                .scaleEffect(isAnimating ? 1.2 : 1)
//                                .animation(
//                                    Animation.easeInOut(duration: 1.5)
//                                        .repeatForever(autoreverses: true)
//                                )
                            Text("Coming Soon.....")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                
                            
                            
                            Image(systemName: "bubble.right.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
//                                .scaleEffect(isAnimating ? 1.2 : 1)
//                                .animation(
//                                    Animation.easeInOut(duration: 1.5)
//                                        .repeatForever(autoreverses: true)
//                                )
//
                        }
                        .scaleEffect(isAnimating ? 1.2 : 1)
                        .animation(
                            Animation.easeInOut(duration: 1.5)
                                .repeatForever(autoreverses: true)
                        )
                        
                            
                            
                    }
                    
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            isAnimating = true
                        }
                    }
                }
                    .tabItem {
                        Image(systemName: "paperplane.fill")
                        Text("Vent House")
                    }
            }
            .accentColor(Color.white)
        }
        
        
    }
}
