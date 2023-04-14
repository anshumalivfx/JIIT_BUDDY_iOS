//
//  HomeView.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 10/04/23.
//

import SwiftUI
import LocalAuthentication

struct HomeView: View {
    
    var body: some View {
        NavigationView {
            HomeLoginView()
                .preferredColorScheme(.dark)
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


