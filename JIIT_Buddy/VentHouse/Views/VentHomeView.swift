//
//  VentHomeView.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 03/05/23.
//

import SwiftUI

struct VentHomeView: View {
    @State var isOn: Bool = false
    @State var dropText: String = ""
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            VStack {
                
            }
        }.overlay {
            NavigationBarVentHouse(searchText: $dropText)
        }.preferredColorScheme(.dark)
    }
}

struct VentHomeView_Previews: PreviewProvider {
    static var previews: some View {
        VentHomeView()
    }
}
