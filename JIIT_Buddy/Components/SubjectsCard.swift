//
//  SubjectsCard.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 15/04/23.
//

import SwiftUI


struct SubjectsCard: View {
    var credit: String
    var subjectname: String
    var subjectCode: String
    var type: String
    var facultyName: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.weatherWidgetBackground.opacity(0.7))
                .background(Blur())
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(subjectname) \(subjectCode)")
                        .font(.footnote)
                        .foregroundColor(.white)
                    Text("\(facultyName)")
                        .font(.footnote)
                        .foregroundColor(.white)
                    Text("Type: \(type)")
                        .font(.footnote)
                        .foregroundColor(.white)
                }
                .padding(.all)
                Spacer()
                Text("\(credit)")
                    .font(.system(size: 45))
                    .foregroundColor(.white)
                    .padding(.all)
            }
            
        }.frame(width: 370, height: 120)
    }
}


