//
//  WebsiteNotWorking.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 18/04/23.
//

import SwiftUI

//struct WebsiteNotWorking: View {
//    var body: some View {
//        ZStack {
//            Color.background.edgesIgnoringSafeArea(.all)
//
//
//            VStack(spacing: 50) {
//                Text("Webportal Ain't Workin'")
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
//
//                Text("Sorry for the Inconvenience")
//                    .font(.caption)
//                    .foregroundColor(.white.opacity(0.5))
//
//
//
//                Text("༎ຶ‿༎ຶ")
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
//            }
//
//
//        }
//    }
//}

struct WebsiteNotWorking: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 50) {
                Text("Webportal Ain't Workin'")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text("Sorry for the Inconvenience")
                    .foregroundColor(.white.opacity(0.5))
                
                Text("༎ຶ‿༎ຶ")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .scaleEffect(isAnimating ? 1.2 : 1)
                    .animation(
                        Animation.easeInOut(duration: 1.5)
                            .repeatForever(autoreverses: true)
                    )
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5)) {
                isAnimating = true
            }
        }
        .onDisappear {
            withAnimation(.easeInOut(duration: 1.5)) {
                isAnimating = false
            }
        }
    }
}



struct WebsiteNotWorking_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteNotWorking()
    }
}
