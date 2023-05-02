//
//  ExaminationScheduleView.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 15/04/23.
//

import SwiftUI




struct ExaminationScheduleView: View {
    @State var loader: Bool = true
    @State var secondaryLoader: Bool = false
    @State var selectedSemesterIndex: Int = 0
    var instituteid: String
    var token: String
    var studentid: String
    @State var semList: [Registration] = []
    @State var gradeCard: [Gradecard] = []
    @State var studentifo: StudentInfoRequest?
    @State var showExamList: Bool = false
    @State var examEvent: [Examevent] = []
    @State var selectedExamIndex: Int = 0
    
    @State var examScheduleData: [ExamSchedule] = []
    var body: some View {
        VStack {
            HStack {
                if loader {
                    Spinner()
                }
                else {
                    Menu {
                        ForEach(0..<semList.count) { index in
                            
                            Button(action: {
                                showExamList = false
                                examEvent = []
                                examScheduleData = []
                                selectedSemesterIndex = index
                                getExamEventDetails(token: token, instituteid: instituteid, registrationid: semList[index].registrationid) { result in
                                    
                                    switch result {
                                    case .success(let response):
                                        print("\(response)")
                                        examEvent = (response.response?.eventcode?.examevent)!
                                        withAnimation {
                                            showExamList = true
                                        }
                                        
                                        
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
                    
                    if showExamList {
                        
                        if (examEvent.isEmpty){
                            EmptyView()
                        }
                        
                        else {
                            Menu {
                                ForEach(0..<examEvent.count) { index in
                                    
                                    Button(action: {
                                        examScheduleData = []
                                        selectedExamIndex = index
                                        requestExamSchedule(token: token, memberid: studentid, instituteid: instituteid, exameventid: examEvent[index].exameventid ?? "", registrationid: semList[selectedSemesterIndex].registrationid) { success in
                                            
                                            switch success {
                                            case .success(let response):
                                                examScheduleData = response.response.subjectinfo
                                            case .failure(let error):
                                                print("\(error)")
                                            }
                                        }
                                    })
                                    {
                                        Text(examEvent[index].exameventdesc ?? "NULL")
                                    }
                                    
                                }
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.ultraThinMaterial)
                                        .frame(width: 200, height: 50)
                                    HStack {
                                        
                                        Text(examEvent[selectedExamIndex].exameventdesc ?? "NULL")
                                        Image(systemName: "chevron.down")
                                    }
                                }
                                .foregroundColor(.white)
                                
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                    
                    
                    
                    
                }
                
                
            }
            .padding(.all)
            Spacer()
            
            if examScheduleData.isEmpty {
                Text("Nothing Selected")
                    .foregroundColor(.white)
            } else {
                ForEach(0..<examScheduleData.count){ index in
                    ExamSittingComponent(subjectName: examScheduleData[index].subject, date: examScheduleData[index].examDate, time: examScheduleData[index].examTime, room: examScheduleData[index].roomNumber == "" ? "NA" : examScheduleData[index].roomNumber, seatNumber: examScheduleData[index].seatNumber == "" ? "NA" : examScheduleData[index].seatNumber )
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

struct ExaminationScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ExaminationScheduleView(instituteid: "", token: "", studentid: "")
    }
}
