//
//  ResultCard.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 15/04/23.
//

import SwiftUI

struct ResultCard: View {
    var semester: String
    var gradePoints: String
    var earnedCredits: String
    var courseCredit: String
    var SGPAP: String
    var CGPAP: String
    
    var SGPA: String
    var CGPA: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.weatherWidgetBackground.opacity(0.7))
                .background(Blur())
            
            HStack {
                Text(semester)
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                    .padding(.all)
                VStack(alignment: .leading) {
                    Text("G Point: \(gradePoints)")
                        .foregroundColor(.white)
                        .font(.footnote)
                    
                    Text("E Credit: \(earnedCredits)")
                        .foregroundColor(.white)
                        .font(.footnote)
                    Text("C Credit: \(courseCredit)")
                        .foregroundColor(.white)
                        .font(.footnote)
                }
                .padding(.all)
                
                VStack(alignment: .leading) {
                    Text("SGPA P: \(SGPAP)")
                        .foregroundColor(.white)
                        .font(.footnote)
                    
                    Text("CGPA P: \(CGPAP)")
                        .foregroundColor(.white)
                        .font(.footnote)
                    
                }
                .padding(.all)
                
                VStack(alignment: .leading) {
                    Text(SGPA)
                        .foregroundColor(.white)
                        .font(.footnote)
                    
                    Text(CGPA)
                        .foregroundColor(.white)
                        .font(.footnote)
                    
                }
                .padding(.all)
            }
        }
        .frame(width: 370, height: 120)
    }
}

struct ResultCard_Previews: PreviewProvider {
    static var previews: some View {
        ResultCard(semester: "1", gradePoints: "6", earnedCredits: "1.5", courseCredit: "1.5", SGPAP: "9", CGPAP: "9", SGPA: "9", CGPA: "9")
    }
}
