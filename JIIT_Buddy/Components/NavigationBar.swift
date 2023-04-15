//
//  NavigationBar.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 11/04/23.
//

import SwiftUI

struct NavigationBar: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isOn: Bool
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                
                Text("Home")
                    .font(.title)
                    .foregroundColor(.primary)
                Spacer()
                
                Button {
                    isOn.toggle()
                    
                }
                label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 28))
                        .frame(width: 44, height: 44, alignment: .trailing)
                }
                .buttonStyle(.plain)
                
                

            }
            .frame(height: 52)
            
            
            
            
        }
        .frame(height: 106, alignment: .top)
        .padding(.horizontal, 16)
        .padding(.top, 42)
        .backgroundBlur(radius: 20, opaque: true)
        .background(Color.navBarBackground)
        .frame(maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
        
    }
}


