//
//  TextFieldLogin.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 10/04/23.
//

import SwiftUI

struct TextFieldLogin: View {
    @State var textField: String
    var placement: String
    var body: some View {
        HStack {
          Image(systemName: "person").foregroundColor(.gray)
          TextField(placement, text: $textField)
          }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
    }
}

struct TextFieldLogin_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldLogin(textField: "", placement: "Username")
    }
}
