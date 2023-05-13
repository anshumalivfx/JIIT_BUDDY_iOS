//
//  NavigationBarVentHouse.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 03/05/23.
//

import SwiftUI

struct NavigationBarVentHouse: View {
    @Environment(\.dismiss) var dismiss
    @Binding var searchText:String
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                
                Text("Vent House")
                    .font(.title)
                    .foregroundColor(.primary)
                Spacer()
                
//                Button {
//                    isOn.toggle()
//
//                }
//                label: {
//                    Image(systemName: "rectangle.portrait.and.arrow.right")
//                        .font(.system(size: 28))
//                        .frame(width: 44, height: 44, alignment: .trailing)
//                }
//                .buttonStyle(.plain)
                
                

            }
            .frame(height: 52)
            HStack(spacing: 2){
                Image(systemName:"bubble.left")
                
                TextEditor(text: $searchText)
                
                Button {
                    
                } label: {
                    
                }
            }
            .foregroundColor(.secondary)
            .padding(.horizontal, 6)
            .padding(.vertical, 7)
            .frame(height: 100, alignment: .leading)
            .background(Color.bottomSheetBackground, in:
                            RoundedRectangle(cornerRadius: 10)
                        
            )
            .innerShadow(shape: RoundedRectangle(cornerRadius: 10), color: .black.opacity(0.25), line: 2, offsetX: 0, offsetY: 2, blur: 2)
            
            
            
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


