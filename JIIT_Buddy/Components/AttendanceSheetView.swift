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
    var classesNeededToAttend: String
    
    
    var body: some View {
        ZStack {
            Trapezoid()
                .fill(Color.weatherWidgetBackground.opacity(0.6))
                .background(Blur())
                .frame(width: 370, height: 150)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                Spacer()
                    
                    Text(courseName)
                        .font(.footnote)
                        .foregroundColor(.white)
                    Spacer()
                    HStack {
                        Text("Total Classes: \(totalClasses)")
                            .font(.caption2)
                            .foregroundColor(.white)
                        Spacer()
                        Text("You Attended: \(totalClasses-TotalPres)")
                            .font(.caption2)
                            .foregroundColor(.white)
                    }
                    
                }
                VStack {
                    StrokeText(text: "\(attpercentage)%", width: 0.5, color: .black)
                                .foregroundColor(.white)
                                .font(.system(size: 45, weight: .medium))
                    Spacer()
//                    Text("Need to Attend: \(classesNeededToAttend)")
//                        .font(.subheadline)
//                        .foregroundColor(.white)
                }
                
                
                
            }.padding(.all)
            
        }
        .frame(width: 372, height: 150)
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

