//
//  GradeCardView.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 15/04/23.
//

import SwiftUI

struct GradeCardView: View {
    @State var loader: Bool = true
    @State var secondaryLoader: Bool = false
    @State var selectedSemesterIndex: Int = 0
    var instituteid: String
    var token: String
    var studentid: String
    @State var semList: [Registration] = []
    @State var gradeCard: [Gradecard] = []
    @State var studentifo: StudentInfoRequest?

    var body: some View {
        VStack {
            if loader {
                Spinner()
            }
            else {
                Menu {
                    ForEach(0..<semList.count) { index in
                        
                        Button(action: {
                            secondaryLoader = true
                            selectedSemesterIndex = index
                            
                            getGradeCard(token: token, studentid: studentid, instituteid: instituteid, registrationid: semList[index].registrationid, branchid: studentifo?.response?.studentinfo?.branchid ?? "NIL", programid: studentifo?.response?.studentinfo?.programid ?? "NIL") { result in
                                switch result {
                                case .success(let response):
                                    gradeCard = response.response!.gradecard
                                    secondaryLoader = false
                                case .failure(let error):
                                    print("\(error)")
                                }
                            }
                            
                        })
                        {
                            Text(semList[index].registrationcode)
                        }
                        
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.ultraThinMaterial)
                            .frame(width: 200, height: 50)
                        HStack {
                            
                            Text(semList[selectedSemesterIndex].registrationcode)
                            Image(systemName: "chevron.down")
                        }
                    }
                    .foregroundColor(.white)
                    
                }
                .buttonStyle(.plain)
                .padding(.all)
                if secondaryLoader {
                    Spinner()
                }
                else {
                    ScrollView {
                        ForEach(0..<gradeCard.count) { index in
                            GradeCard(subjectname: gradeCard[index].subjectdesc, subjectCode: gradeCard[index].subjectcode, courseCredit: String(gradeCard[index].coursecreditpoint ?? 0), grade: String(gradeCard[index].grade ?? "NIL"))
                        }
                    }
                }
                
                
            }
        }
        .onAppear {
            getStudentRegisteredSubjects(token: token, studentid: studentid, instituteid: instituteid) { result in
                loader = true
                switch result {
                case .success(let response):
                    semList = response.response.registrations
                    
                    getStudentInformation(token: token, studentid: studentid, instituteid: instituteid) { result in
                        switch result {
                        case .success(let response):
                            studentifo = response
                        case .failure(let error):
                            print("\(error)")
                        }
                    }
                    loader = false
                case .failure(let error):
                    print("\(error)")
                }
            }
        }
    }
}

struct GradeCardView_Previews: PreviewProvider {
    static var previews: some View {
        GradeCardView(instituteid: "", token: "", studentid: "")
    }
}
