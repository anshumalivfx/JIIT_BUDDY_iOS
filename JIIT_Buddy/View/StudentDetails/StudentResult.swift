//
//  StudentResult.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 15/04/23.
//

import SwiftUI

struct StudentResult: View {
    var studentResult: [ResultSemesterList]
    var body: some View {
        ZStack {
            
            ScrollView {
                ForEach(0..<studentResult.count) { index in
                    ResultCard(semester: String(format: "%.f", studentResult[index].stynumber ?? 1), gradePoints: String(studentResult[index].earnedgradepoints ?? 0.0), earnedCredits: String(studentResult[index].totalearnedcredit ?? 0.0), courseCredit: String(studentResult[index].totalearnedcredit ?? 0.0), SGPAP: String(studentResult[index].totalpointsecuredsgpa ?? 0.0), CGPAP: String(studentResult[index].totalpointsecuredcgpa ?? 0.0), SGPA: String(studentResult[index].sgpa ?? 0.0), CGPA: String(studentResult[index].cgpa ?? 0.0))
                        
                }
            }
        }
        .padding(.top)
    }
}


