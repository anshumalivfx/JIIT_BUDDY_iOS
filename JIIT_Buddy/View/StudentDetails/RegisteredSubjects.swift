//
//  RegisteredSubjects.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 15/04/23.
//

import SwiftUI

struct RegisteredSubjects: View {
    var token: String
    var StudentId: String
    @State var loader: Bool = true
    @State var secondaryLoader = false
    @State var semList: [Registration] = []
    @State var allSubjects: [RegistrationSubject] = []
    @State var selectedSemesterIndex = 0
    var instituteid: String
    var body: some View {
        VStack {
            
            if loader {
                Spinner()
            }
            else {
                VStack {
                    Menu {
                        ForEach(0..<semList.count) { index in
                            
                            Button(action: {
                                secondaryLoader = true
                                allSubjects = []
                                selectedSemesterIndex = index
                                getFaculities(token: token, studentid: StudentId, registrationid: semList[index].registrationid, instituteid: instituteid) { result in
                                    switch result {
                                    case .success(let response):
                                        allSubjects = response.response.registrations
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
                    
                    ScrollView {
                        if secondaryLoader {
                            Spinner()
                        }
                        
                        else {
                            if (allSubjects.isEmpty){
                                Text("Nothing Selected")
                            }
                            else {
                                ForEach(0..<allSubjects.count) { index in
                                    SubjectsCard(credit: String(format: "%.f", Double(allSubjects[index].credits ?? 0)), subjectname: allSubjects[index].subjectdesc ?? "NULL", subjectCode: allSubjects[index].subjectcode ?? "NULL", type: allSubjects[index].subjectcomponentcode ?? "NULL", facultyName: allSubjects[index].employeename ?? "NULL")
                                }
                            }
                        }
                    }
                    
                    
            }
            
            
            }
            
            
        }
        .onAppear {
            loader = true
            getStudentRegisteredSubjects(token: token, studentid: StudentId, instituteid: instituteid) { result in
                switch result {
                case .success(let response):
                    semList = response.response.registrations
                    
                    loader = false
                    
                case .failure(let error):
                    print("\(error)")
                }
            }
        }
        
        
    }
}
    


