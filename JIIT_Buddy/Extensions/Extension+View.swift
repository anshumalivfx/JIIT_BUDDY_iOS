//
//  Extension+View.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 13/04/23.
//

import SwiftUI

extension View {
    func blurredSheet<Content: View>(_ style: AnyShapeStyle, show: Binding<Bool>, onDismiss: @escaping ()->(), @ViewBuilder content: @escaping ()->Content)->some View{
        self.sheet(isPresented: show, onDismiss: onDismiss) {
            content()
                .background(RemoveBackgroundColor())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background{
                    Rectangle()
//                        .fill(style)
                        .opacity(0)
                        .backgroundBlur(radius: 15, opaque: true)
                    
                        
                        .ignoresSafeArea(.container, edges: .all)
                }
        }
    }
}


struct RemoveBackgroundColor: UIViewRepresentable {
    func makeUIView(context: Context) ->  UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            uiView.superview?.superview?.backgroundColor = .clear
        }
    }
}



