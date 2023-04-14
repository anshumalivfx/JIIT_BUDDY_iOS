//
//  MainPageView.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 11/04/23.
//

import SwiftUI

struct MainPageView: View {
    var memberId: String
    var clientId: String
    var tokenResponse: String
    @State var personalInformation: PersonalInfoResponse?
    @AppStorage("isAuthenticated") var isAuthenticated = true
    @AppStorage("token") var token: String = ""
    @AppStorage("clientid") var clientid: String = ""
    @AppStorage("memberid") var memberid: String = ""
    @State var showAlert: Bool = false
    @State var LogOutAlertisOn: Bool = false
    @State var spinner: Bool = false
    
    
    @State var showAttendance: Bool = false
    
    
    @State var attendance: Bool = false
    @State var registeredSubjects: Bool = false
    @State var result: Bool = false
    @State var grade: Bool = false
    @State var subjectMarks: Bool = false
    
    
    @State var isSidebarOpen: Bool = false
    init(memberid: String,clientId: String, tokenResponse: String) {
        self.memberId = memberid
        self.clientId = clientId
        self.tokenResponse = tokenResponse
        self.spinner = true
    }
    
    var body: some View {
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
                            Button {
                                showAttendance = true
                            } label: {
                                SelectComponent(textBody: "View Attendance", imageName: "books.vertical.fill")
                            }
                            .buttonStyle(.plain)
                            
                            Button {
                                
                            } label: {
                                SelectComponent(textBody: "View Result", imageName: "graduationcap.circle")
                            }
                            .buttonStyle(.plain)
                            Button {
                                
                            } label: {
                                SelectComponent(textBody: "Grade Card", imageName: "testtube.2")
                            }
                            .buttonStyle(.plain)
                            Button {
                                
                            } label: {
                                SelectComponent(textBody: "Subject Marks", imageName: "rectangle.and.pencil.and.ellipsis.rtl")
                            }
                            .buttonStyle(.plain)
                            Button {
                                
                            } label: {
                                SelectComponent(textBody: "Examination Schedule", imageName: "calendar")
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
        .overlay {
            NavigationBar(isOn: $LogOutAlertisOn)
        }
        .onAppear {
            self.spinner = true
            getPersonalInformation(memberId: self.memberId, clientId: self.clientId, token: self.tokenResponse) { result in
                
                
                switch result {
                case .success(let personalInfoResponse):
                    // Do something with the response
                    personalInformation = personalInfoResponse
                    self.spinner = false
                case .failure(let error):
                    // Handle the error
                    isAuthenticated = false
                    
                    print(error)
                    showAlert = true
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Internal Server Error from CampusLynx"), primaryButton: Alert.Button.default(Text("Retry"), action: {
                self.spinner = true
                getPersonalInformation(memberId: self.memberId, clientId: self.clientId, token: self.tokenResponse) { result in
                    
                    
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
        
        .blurredSheet(.init(.ultraThinMaterial), show: $showAttendance, onDismiss: {
            
        }, content: {
            AttendanceView(studentid: memberid, token: token)
                .preferredColorScheme(.dark)
//            NewView()
        })
        
//        .sheet(isPresented: $showAttendance, content: {
//            AttendanceView(studentid: memberid, token: token)
//
//
//
//        })
        .preferredColorScheme(.dark)
    }
    
    
    func logout(){
        isAuthenticated = false
        memberid = ""
        clientid = ""
        token = ""
    }
}


struct NewView: View {
    var body : some View {
        VStack {
            
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            MainPageView(memberid: "00012002467", clientId: "JAYPEE", tokenResponse: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI2ZVBZc1ZZQWtQTnpLRCtQd2JTOFVBPT0iLCJzY29wZXMiOlt7ImF1dGhvcml0eSI6IlJPTEVfU1RVREVOVCJ9XSwiaXNzIjoiaHR0cDovL2NhbXB1c2x5bnguY29tIiwiaWF0IjoxNjgxMzk4NDM5LCJleHAiOjE2ODE0ODg0Mzl9.W6uClUZI3nC1HSGlG8lNKC6lU2Yd4KXb5p36kjRXw-0")
        }
    }
}

