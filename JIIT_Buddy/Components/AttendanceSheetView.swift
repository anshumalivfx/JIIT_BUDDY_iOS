//
//  AttendanceSheetView.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 12/04/23.
//

import SwiftUI

struct AttendanceSheetView: View {
    @State var attendance = 0
    var attpercentage: String
    var courseName: String
    var totalClasses: Int
    var TotalPres: Int
    var final = 45
    var registrationId: String
    var subjectComponentId: [String]
    var token: String
    var studentid: String
    var subjectid: String

    var body: some View {
        ZStack {
            Trapezoid()
                .fill(Color.weatherWidgetBackground.opacity(0.6))
                .background(Blur())
                .frame(width: 370, height: 150)
            
            HStack(alignment: .top) {
                VStack {
                Spacer()
                    Text(courseName)
                        .font(.footnote)
                        .foregroundColor(.white)
                    
                    Text("Total Classes: \(totalClasses)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    Text("You Attended: \(totalClasses-TotalPres)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                Spacer()
                VStack {
                    StrokeText(text: "\(attpercentage)%", width: 0.5, color: .black)
                                .foregroundColor(.white)
                                .font(.system(size: 45, weight: .medium))
                    Spacer()
                }
                
                
                
            }.padding(.all)
            
        }
        .frame(width: 372, height: 150)
    }
}

struct AttendanceSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceSheetView(attpercentage: "40", courseName: "PROBABILITY AND RANDOM PROCESSES(15B11MA301)",totalClasses: 32, TotalPres: 14, registrationId: "J50505", subjectComponentId: ["Hello"], token: "", studentid: "", subjectid: "")
    }
}



struct StrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            Text(text)
        }
    }
}
