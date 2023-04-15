//
//  EventMarksView.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 15/04/23.
//

import SwiftUI

struct EventMarksView: View {
    @State var loader: Bool = true
    @State var secondaryLoader: Bool = false
    @State var selectedSemesterIndex: Int = 0
    var instituteid: String
    var token: String
    var studentid: String
    @State var semList: [Registration] = []
    @State var gradeCard: [Gradecard] = []
    @State var studentifo: StudentInfoRequest?
    
    @State var pdf: Data?
    
    
    var body: some View {
        VStack {
            if loader {
                Spinner()
            }
            else {
                Menu {
                    ForEach(0..<semList.count) { index in
                        
                        Button(action: {
                            self.pdf = nil
                            secondaryLoader = true
                            selectedSemesterIndex = index
                            
                            getEventMarks(token: token, studentid: studentid, instituteid: instituteid, registrationid: semList[index].registrationid, semesterdesc: semList[index].registrationcode) { data, error in
                                if let error = error {
                                    print("Error: \(error.localizedDescription)")
                                    return
                                }
                                guard let data = data else {
                                    print("No data returned")
                                    return
                                }
                                
                                self.pdf = data
                                
                                
                                secondaryLoader = false
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
                Spacer()
                if secondaryLoader {
                    Spinner()
                }
                
                else {
                    if pdf == nil {
                        Text("Nothing selected")
                    }
                    else {
                        PDFViewWrapper(data: pdf!)
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

struct EventMarksView_Previews: PreviewProvider {
    static var previews: some View {
        EventMarksView(instituteid: "", token: "", studentid: "")
    }
}
