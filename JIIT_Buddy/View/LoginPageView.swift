//
//  LoginPageView.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 10/04/23.
//

import SwiftUI


struct HomeLoginView: View {
    @State var rollno: String = ""
    @State var password:String = ""
    @State var spinner: Bool = false
    @AppStorage("isAuthenticated") var isAuthenticated = false
    @AppStorage("token") var tokenResponse: String = ""
    @AppStorage("clientid") var clientId: String = ""
    @AppStorage("memberid") var memberid: String = ""
    @State private var opacity = 0.0
    @State private var showAlert: Bool = false

    var body: some View {
        VStack {
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("Login to JIIT Buddy")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Please SignIn to Continue")
                        .foregroundColor(Color.white.opacity(0.5))
                }
                Spacer(minLength: 0)
            }.padding(.horizontal)
            
            HStack {
                Image(systemName: "number")
                    .font(.title2)
                    .foregroundColor(.white)
                TextField("User ID", text: $rollno)
                    .keyboardType(.numberPad)
                    .onChange(of: rollno) { newValue in
                        withAnimation {
                            if rollno != "" && password != "" {
                                opacity = 1
                            }
                        }
                    }
                
                
            }.padding(.all)
                .background(Color.white.opacity(rollno == "" ? 0 : 0.12))
                .cornerRadius(20)
                .padding(.horizontal)
            
            HStack {
                Image(systemName: "lock")
                    .font(.title2)
                    .foregroundColor(.white)
                SecureField("Password", text: $password)
                    .onChange(of: password) { newValue in
                        withAnimation(.easeIn) {
                            if rollno != "" && password != "" {
                                opacity = 1
                            }
                            else {
                                opacity = 0
                            }
                        }
                    }
                
                
            }.padding(.all)
                .background(Color.white.opacity(password == "" ? 0 : 0.12))
                .cornerRadius(20)
                .padding(.horizontal)
            
            
            Button {
                spinner = true
                signInUser(rollno: self.rollno, password: self.password) { result in
                    switch result {
                    case .success(let user):
                        
                        self.tokenResponse = user.response.regdata.token
                        self.clientId = user.response.regdata.clientid
                        self.memberid = user.response.regdata.memberid
                        token = user.response.regdata.token
                        clientid = user.response.regdata.clientid
                        memberid = user.response.regdata.memberid
                        print(user.response.regdata.token)
                        spinner = false
                        
                        
                        self.isAuthenticated = true
                        
                        

                    case .failure(let error):
                        spinner = false
                        showAlert = true
                        print("\(error.localizedDescription)")
                    }
                }
            } label: {
                if spinner {
                    Spinner()
                }
                else {
                    Text("LOGIN")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                        .background(Color("green"))
                        .clipShape(Capsule())
                }
                
            }
            .padding(.top)
            .opacity(opacity)
            .disabled(rollno != "" && password != "" ? false : true)
            Spacer(minLength: 0)
            
            Text("Anshumali Karna's love-infused creation ❤️")
                .foregroundColor(.white.opacity(0.8))
                 .frame(alignment: .bottom)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Invalid Credentials! \n Check your User Id and Password"), dismissButton: .default(Text("Ok")))
        }
        .background(Color.background)
        
        
        
    }
    
    
    
}