//
//  ExamSittingComponent.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 29/04/23.
//

import SwiftUI

struct ExamSittingComponent: View {
    var subjectName: String
    var date: String
    var time: String
    var room: String
    var seatNumber: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.weatherWidgetBackground)
                .background(Blur())
                .opacity(0.7)
            HStack {
                VStack(alignment: .leading) {
                    Text(subjectName)
                        .lineLimit(2)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    HStack {
                        VStack(alignment: .leading){
                            Text("Date: \(date)")
                                   .font(.callout)
                                   .foregroundColor(.white)
                               Text("Time: \(time)")
                                      .font(.callout)
                                      .foregroundColor(.white)
                        }
                     
                    
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Room No: \(room)")
                                   .font(.callout)
                                   .foregroundColor(.white)
                            Text("Seat Number: \(seatNumber)")
                                .font(.callout)
                                .foregroundColor(.white)
                        }
                        
                    }
                }
                .padding(.all)
                
                
            }
            
        }.frame(width: UIScreen.main.bounds.width - 30, height: 120)
    }
}

struct ExamSittingComponent_Previews: PreviewProvider {
    static var previews: some View {
        ExamSittingComponent(subjectName: "Software Engineering", date: "", time: "", room: "", seatNumber: "" )
    }
}
