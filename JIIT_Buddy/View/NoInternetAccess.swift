//
//  NoInternetAccess.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 15/04/23.
//

import SwiftUI


struct NoNetworkAccess: View {
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            
            
            VStack(spacing: 50) {
                Text("NO INTERNET")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                
                
                Text("¯\\_༼ ಥ ‿ ಥ ༽_/¯")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            
            
        }
    }
}


struct NoNetworkAccess_Previews: PreviewProvider {
    static var previews: some View {
        NoNetworkAccess()
    }
}

