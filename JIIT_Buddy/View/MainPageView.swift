//
//  MainPageView.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 11/04/23.
//

import SwiftUI
import LocalAuthentication

struct MainPageView: View {
    var memberId: String
    var clientId: String
    var tokenResponse: String
    @State var personalInformation: PersonalInfoResponse?
    @State var faceUnlock: Bool = false
    @FocusState var isfieldFocused: Bool
    @AppStorage("isAuthenticated") var isAuthenticated = true
    @AppStorage("token") var token: String = ""
    @AppStorage("clientid") var clientid: String = ""
    @AppStorage("memberid") var memberid: String = ""
    @AppStorage("instituteid") var instituteid: String = ""
    @AppStorage("attendancecriteria") var criteria: Double = 0.0
    
    @AppStorage("userid") var userid: String = ""
    @AppStorage("password") var userpassword: String = ""
    @State var showAlert: Bool = false
    @State var LogOutAlertisOn: Bool = false
    @State var spinner: Bool = false
    
    @State var attendanceCriteria: String = ""
    
    @State var Result: [ResultSemesterList] = []
    
    
    @State var showResult: Bool = false
    
    
    @State var showAttendance: Bool = false
    
    
    @State var attendance: Bool = false
    @State var registeredSubjects: Bool = false
    @State var result: Bool = false
    @State var grade: Bool = false
    @State var subjectMarks: Bool = false
    
    
    @State var isSidebarOpen: Bool = false
    
    @State var showRegisteredSubjects: Bool = false
    
    @State var showGradeCard: Bool = false
    
    @State var showEventMarks: Bool = false
    
    @State var showExamSchedule: Bool = false
    
    @State var showAttendanceCriteria: Bool = false
    
    init(memberid: String,clientId: String, tokenResponse: String) {
        self.memberId = memberid
        self.clientId = clientId
        self.tokenResponse = tokenResponse
        self.spinner = true
    }
    
    var body: some View {
        if faceUnlock {
            NavigationView {
                ZStack {
                    Color.background.ignoresSafeArea(.all, edges: .all)
                    if spinner {
                        Spinner()
                    }
                    else {
                        VStack(alignment: .leading) {
                            
                            ScrollView {
                                ZStack {
                                    Trapezoid()
                                        .fill(Color.weatherWidgetBackground)
                                        .frame(width: 342, height: 174)
                                    HStack(alignment: .bottom) {
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text("\(personalInformation?.response.generalinformation.studentname ?? "NULL")")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                            VStack(alignment: .leading) {
                                                Text("\(personalInformation?.response.generalinformation.registrationno ?? "NULL")")
                                                Text("\(personalInformation?.response.generalinformation.programcode ?? "NULL") \(personalInformation?.response.generalinformation.academicyear ?? "NULL") \(personalInformation?.response.generalinformation.batch ?? "NULL")")
                                                
                                            }
                                            
                                            
                                        }
                                        .padding(.all)
                                        Spacer()
                                        
                                        
                                        VStack {
                                            Image(systemName: "graduationcap.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .padding(.trailing, 4)
                                            
                                        }
                                        
                                    }
                                }.frame(width: 342)
                                
                                VStack {
                                    HStack {
                                        Button {
                                            showAttendance = true
                                        } label: {
                                            SelectComponent(textBody: "View Attendance", imageName: "studentdesk")
                                        }
                                        .buttonStyle(.plain)
                                        .frame(width: 242)
                                    }
                                    
                                    
                                    Button {
                                        showRegisteredSubjects = true
                                    } label: {
                                        SelectComponent(textBody: "View Registered Subjects", imageName: "books.vertical")
                                    }
                                    .buttonStyle(.plain)
                                    
                                    Button {
                                        showResult.toggle()
                                    } label: {
                                        SelectComponent(textBody: "View Result", imageName: "graduationcap.circle")
                                    }
                                    .buttonStyle(.plain)
                                    Button {
                                        showGradeCard = true
                                    } label: {
                                        SelectComponent(textBody: "Grade Card", imageName: "testtube.2")
                                    }
                                    .buttonStyle(.plain)
                                    Button {
                                        showEventMarks.toggle()
                                    } label: {
                                        SelectComponent(textBody: "Subject Marks", imageName: "rectangle.and.pencil.and.ellipsis.rtl")
                                    }
                                    .buttonStyle(.plain)
                                    Button {
                                        showExamSchedule.toggle()
                                    } label: {
                                        SelectComponent(textBody: "Examination Schedule", imageName: "calendar")
                                    }
                                    .buttonStyle(.plain)
                                    
                                    Button {
                                        showAttendanceCriteria.toggle()
                                        
                                    } label: {
                                        SelectComponent(textBody: "Set Attendance Criteria", imageName: "exclamationmark.circle")
                                    }
                                    .buttonStyle(.plain)
                                    
                                    
                                    //
                                }
                            }
                            
                            Spacer()
                            
                            
                            
                            
                            
                            
                            Spacer()
                            
                    
                            
                            Text("Anshumali Karna's love-infused creation ❤️")
                                .foregroundColor(.white.opacity(0.8))
                                .frame(alignment: .bottom)
                            
                        }
                        .safeAreaInset(edge: .top) {
                            EmptyView()
                                .frame(height: 110)
                        }
                    }
                    
                    
                }
                .overlay(content: {
                    ZStack {
                        NavigationBar(isOn: $LogOutAlertisOn)
                    }

                })
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack(alignment: .center) {
                            Button {
                                LogOutAlertisOn.toggle()
                                
                            }
                            label: {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .font(.system(size: 28))
                                    .frame(width: 44, height: 44, alignment: .trailing)
                            }
                        .buttonStyle(.plain)
                        }
                    }
                    
                })
                    .onAppear {
                        self.spinner = true
                        DispatchQueue.main.async {
                            getPersonalInformation(memberId: self.memberId, clientId: self.clientId, token: self.tokenResponse, instituteid: instituteid) { result in
                                
                                
                                switch result {
                                case .success(let personalInfoResponse):
                                    // Do something with the response
                                    personalInformation = personalInfoResponse
                                    
                                case .failure(let error):
                                    // Handle the error
                                    isAuthenticated = false
                                    
                                    print(error)
                                    showAlert = true
                                }
                            }
                        }
                        
                        print(memberid)
                        print(instituteid)
                        
                        getStudentResult(token: token, studentid: memberid, stynumber: String((personalInformation?.response.generalinformation.semester ?? 1)), instituteid: instituteid) { result in
                            switch result {
                            case .success(let response):
                                Result = response.response.semesterList
                                self.spinner = false
                            case .failure(let error):
                                print("\(error)")
                            }
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Internal Server Error from CampusLynx"), primaryButton: Alert.Button.default(Text("Retry"), action: {
                            self.spinner = true
                            getPersonalInformation(memberId: self.memberId, clientId: self.clientId, token: self.tokenResponse, instituteid: instituteid) { result in
                                switch result {
                                case .success(let personalInfoResponse):
                                    // Do something with the response
                                    personalInformation = personalInfoResponse
                                    self.spinner = false
                                case .failure(let error):
                                    // Handle the error
                                    showAlert = true
                                    print(error)
                                    spinner = false
                                }
                            }
                        }), secondaryButton: .destructive(Text("Quit JIIT Buddy"), action: {
                            exit(0)
                        }))
                        
                        
                        
                    }
                    .alert(isPresented: $LogOutAlertisOn, content: {
                        Alert(title: Text("Logout?"), primaryButton: .default(Text("Yes"), action: {
                            logout()
                        }), secondaryButton: .cancel(Text("Cancel"), action: {
                            
                        }))
                    })
                    
                    .blurredSheet(.init(.thinMaterial), show: $showAttendance, onDismiss: {
                        
                    }, content: {
                        AttendanceView(studentid: memberid, token: token)
                            .preferredColorScheme(.dark)
                        //            NewView()
                    })
                    .blurredSheet(.init(.ultraThinMaterial), show: $showResult, onDismiss: {
                        
                    }, content: {
                        StudentResult(studentResult: Result)
                            .background(RemoveBackgroundColor())
                    })
                    .blurredSheet(.init(.ultraThinMaterial), show: $showRegisteredSubjects, onDismiss: {
                        
                    }, content: {
                        RegisteredSubjects(token: token, StudentId: memberid, instituteid: instituteid)
                    })
                    .blurredSheet(.init(.ultraThinMaterial), show: $showGradeCard, onDismiss: {
                        
                    }, content: {
                        GradeCardView(instituteid: instituteid, token: token, studentid: memberid)
                    })
                    .blurredSheet(.init(.ultraThinMaterial), show: $showEventMarks, onDismiss: {
                        
                    }, content: {
                        EventMarksView(instituteid: instituteid, token: token, studentid: memberid)
                    })
                    
                    .blurredSheet(.init(.ultraThinMaterial), show: $showExamSchedule, onDismiss: {
                        
                    }, content: {
                        ExaminationScheduleView(instituteid: instituteid, token: token, studentid: memberid)
                    })
                    .alert("Set Attendance Criteria", isPresented: $showAttendanceCriteria, actions: {
                        TextField("Attendance %", text: $attendanceCriteria).focused($isfieldFocused)
                            .keyboardType(.numberPad)
                            .foregroundColor(.black)
                        Button {
                            isfieldFocused = false
                            criteria = Double(attendanceCriteria) ?? 0.0
                        } label: {
                            Text("Submit")
                        }

                    })
                
                
                
                    
                
                
        //        .sheet(isPresented: $showAttendance, content: {
        //            AttendanceView(studentid: memberid, token: token)
        //
        //
        //
        //        })
            .preferredColorScheme(.dark)
            }
        } else {
            ZStack {
                Color.background.ignoresSafeArea(.all)
                VStack {
                    Text("Please Authenticate Before Using Biometrics/Device PIN")
                        .font(.largeTitle)
                    Button {
                        faceIDAuth()
                    } label: {
                        Text("Trigger Biometrics/Device PIN")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 150)
                            .background(Color("green"))
                            .clipShape(Capsule())
                    }

                }
            }
                .onAppear {
                    faceIDAuth()
                }
        }
        
        
        
                     
    }
    
    
    func logout(){
        
        memberid = ""
        clientid = ""
        token = ""
        instituteid = ""
        userid = ""
        userpassword = ""
        
        isAuthenticated = false
    }
    
    
    func faceIDAuth(){
        let context = LAContext()
        var error: NSError?
        spinner = true
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Login Using Face Id or Touch Id") { success, authError in

                DispatchQueue.main.async {
                    if success {
                        signInUser(rollno: self.userid, password: self.userpassword) { result in
                            switch result {
                            case .success(let user):
                                self.token = user.response.regdata.token
                                self.clientid = user.response.regdata.clientid
                                self.memberid = user.response.regdata.memberid
                                
                                token = user.response.regdata.token
                                clientid = user.response.regdata.clientid
                                memberid = user.response.regdata.memberid
                                instituteid = user.response.regdata.institutelist[0].value
                                print(user.response.regdata.token)
                                spinner = false
                                
                                
                                self.isAuthenticated = true
                                self.faceUnlock = true
                                

                            case .failure(let error):
                                spinner = false
                                showAlert = true
                                print("\(error.localizedDescription)")
                            }
                        }
                    } else {
                        NSLog("\(error?.localizedDescription)")
                        spinner = false
                    }
                }
                
                
            }
        } else {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Enter Device PIN to Login") { success, error in
                
                DispatchQueue.main.async {
                    if success {
                        signInUser(rollno: self.userid, password: self.userpassword) { result in
                            switch result {
                            case .success(let user):
                                token = user.response.regdata.token
                                clientid = user.response.regdata.clientid
                                memberid = user.response.regdata.memberid
                                instituteid = user.response.regdata.institutelist[0].value
                                print(token)
                                spinner = false
                                
                                
                                self.isAuthenticated = true
                                
                                self.faceUnlock = true
                                

                            case .failure(let error):
                                spinner = false
                                showAlert = true
                                print("\(error.localizedDescription)")
                            }
                        }
                    } else {
                        NSLog("\(error?.localizedDescription)")
                        spinner = false
                    }
                }
            }
        }
        
    }
}




struct NewView: View {
    var body : some View {
        VStack {
            
        }
    }
}



