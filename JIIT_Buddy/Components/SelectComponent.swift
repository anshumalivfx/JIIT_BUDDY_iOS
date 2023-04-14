//
//  SelectComponent.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 12/04/23.
//

import SwiftUI

struct SelectComponent: View {
    var textBody: String?
    var imageName: String?
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.white.opacity(0.2))
                .background(Blur())
            HStack(alignment: .top) {
                Text(textBody!)
                Spacer()
                Image(systemName: imageName!)
            }.padding(.all)
            
        }
        .frame(width: 342, height: 50)
    }
}

struct SelectComponent_Previews: PreviewProvider {
    static var previews: some View {
        SelectComponent(textBody: "Hello", imageName: "person")
    }
}
