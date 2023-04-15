//
//  GradeCard.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 15/04/23.
//

import SwiftUI

struct GradeCard: View {
    var subjectname: String?
    var subjectCode: String?
    var courseCredit: String?
    var grade: String?
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.weatherWidgetBackground.opacity(0.6))
                .background(Blur())
            
            VStack {
                HStack {
                    Text("\(subjectname!) \(subjectCode!)")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(.all)
                    Spacer()
                }
                
                HStack {
                    Text("Course Credit: \(courseCredit!)")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    Spacer()
                    Text("Grade: \(grade!)")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                }
                
            }
            
            
        }
        .frame(width: 370, height: 120)
    }
}

struct GradeCard_Previews: PreviewProvider {
    static var previews: some View {
        GradeCard(subjectname: "COA", subjectCode: "1211B", courseCredit: "1", grade: "Grade")
    }
}
