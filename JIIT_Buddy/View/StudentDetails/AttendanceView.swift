//
//  AttendanceView.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 12/04/23.
//

import SwiftUI

struct AttendanceView: View {
    var studentid: String
    var token: String
    @AppStorage("instituteid") var instituteid = ""
    @AppStorage("attendancecriteria") var criteria: Double?
    @State var showAttendanceDetails: Bool = false
    @State var stynumber: String = ""
    @State var headerList: String = ""
    @State var loader: Bool = true
    @State var showsemAtt: Bool = false
    @Environment(\.dismiss) var dismiss
    @State var options = ["":""]
    @State private var selectedSemesterIndex = 0
    @State var semList: [Semester] = []
    @State var attendanceDict: [Studentattendancelist] = []
    @State var attendanceVal: [Double] = []
    @State var registrationID: String = ""
    @State var attendanceSummary: [StudentAttdsummarylist] = []
    @State var totalClasses: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @State var needToAttend: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @State private var subjectIndex = 0
    var body: some View {
        ZStack {
            if loader {
                Spinner()
                
            }
            else {
                VStack {
                    Menu {
                        ForEach(0..<semList.count) { index in
                            Button(action: {
                                print("semList[selectedSemesterIndex].registrationid")
                                selectedSemesterIndex = index
                                attendanceDict = []
                                getSemesterAttendance(studentid: studentid, stynumber: stynumber, registrationid: semList[selectedSemesterIndex].registrationid, token: token, instituteid: instituteid) { result in
                                    switch result {
                                    case .success(let attendance):
                                        // Handle the retrieved attendance data
                                     
                                            attendanceDict = attendance.response.studentattendancelist
                                            registrationID = semList[selectedSemesterIndex].registrationid
                                        
                                        for _ in 0...attendanceDict.count{
                                            attendanceVal.append(0)
//                                            totalAttendedClasses.append(0)
                                        }
                                        showsemAtt = true
                                    case .failure(let error):
                                        // Handle the error
                                        print(error.localizedDescription)
                                    }
                                }
                            }) {
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
                    ScrollView {
                        if showsemAtt {
                            if attendanceDict.count == 0 {
                                Text("Select Sem Code to View Attendance")
                                    .foregroundColor(.white)
                            }
                            else {
                                ForEach(0..<attendanceDict.count) { i in
                                    
                                    if (attendanceDict.count == 0)
                                    {
                                        Text("No Data")
                                    }
                                        else {
                                        Button {
                                            getPercentageDetails(token: token, studentid: studentid, subjectid: attendanceDict[i].subjectid, registrationid: registrationID, instituteid: instituteid, subjectcomponentids: [attendanceDict[i].lsubjectcomponentid, attendanceDict[i].tsubjectcomponentid, attendanceDict[i].psubjectcomponentid], completion: { result in
                                                switch result {
                                                case .success(let attendancePercentageDetails):
                                                    
                                                    attendanceSummary = attendancePercentageDetails.response.studentAttdsummarylist
                                                    print(attendanceSummary.count)
                                                    
                                                case .failure(let error):
                                                    print("Error: \(error.localizedDescription)")
                                                }
                                            })
                                            
                                            showAttendanceDetails.toggle()
                                        } label: {
                                            
                                            
                                            
                                            AttendanceSheetView(attpercentage: "\(attendanceVal[i])", courseName: "\(attendanceDict[i].subjectcode)", totalClasses:totalClasses[i], TotalPres: attendanceDict[i].abseent, registrationId: registrationID, subjectComponentId: [attendanceDict[i].lsubjectcomponentid, attendanceDict[i].tsubjectcomponentid, attendanceDict[i].psubjectcomponentid],token: token, studentid: studentid, subjectid: attendanceDict[i].subjectid, classesNeededToAttend: String(needToAttend[i])).onAppear{
                                                
                                                totalClasses[i] = attendanceSummary.count
                                                
                                                if (convertNtageToDouble(attendanceDict[i].ppercentage)==0){
                                                    
                                                    if convertNtageToDouble(attendanceDict[i].lTpercantage) == 0 {
                                                        attendanceVal[i] = (convertNtageToDouble(attendanceDict[i].lpercentage))
                                                    }
                                                    else {
                                                        attendanceVal[i] = (convertNtageToDouble(attendanceDict[i].lTpercantage))
                                                    }
                                                    
                                                }
                                                else {
                                                    attendanceVal[i] = (convertNtageToDouble(attendanceDict[i].ppercentage))
                                                }
                                                
                                                
                                                
                                                
                                                
                                                getPercentageDetails(token: token, studentid: studentid, subjectid: attendanceDict[i].subjectid, registrationid: registrationID, instituteid: instituteid, subjectcomponentids: [attendanceDict[i].lsubjectcomponentid, attendanceDict[i].tsubjectcomponentid, attendanceDict[i].psubjectcomponentid], completion: { result in
                                                    switch result {
                                                    case .success(let attendancePercentageDetails):
                                                        
                                                        attendanceSummary = attendancePercentageDetails.response.studentAttdsummarylist
                                                        
                                                        totalClasses[i] = Int(attendanceSummary.count)
                                                        
                                                    case .failure(let error):
                                                        print("Error: \(error.localizedDescription)")
                                                    }
                                                })
                                                
                                                
                                                let criteria = (self.criteria ?? 0.0)/100
                                                
                                                print(criteria)
                                                
                                                if criteria > attendanceVal[i]/100 {
                                                    let classesAttended = Int(totalClasses[i] - attendanceDict[i].abseent)
                                                    needToAttend[i] = Int((criteria * Double(totalClasses[i]) - Double(classesAttended)))
                                                    print(needToAttend[i])
                                                }
                                                
                                                
                                                
                                                
                                            }
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                        }
                        else {
                            Text("Nothing Selected")
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                    Text(semList[selectedSemesterIndex].registrationcode)
                }
                
                
            }
            
            
            
        }
        
    
        
        .onAppear {
            
            getAttendance(studentId: studentid, token: token, instituteid: instituteid) { result in
                loader = true
                switch result {
                case .success(let payload):
                    let headerlist = payload.headerlist
                    headerList = headerlist[0].name
                    stynumber = headerlist[0].stynumber
                    print(headerlist)
                    let semlist = payload.semlist
                    semList = semlist
                    print(semlist)
                    loader = false
                    // Do something with the headerlist and semlist data
                case .failure(let error):
                    loader = false
                    headerList = "error"
                    print("Error fetching attendance data: \(error)")
                    dismiss()
                }
            }
            
            
            
        }
        .blurredSheet(.init(.thinMaterial), show: $showAttendanceDetails) {
            
        } content: {
            AttendanceSummarySheet(data: attendanceSummary)
                .background(RemoveBackgroundColor())
        }

    }
    
    func calculateTotalClasses(attendancePercentage: Double, classesMissed: Int) -> Int {
        
        return Int(Double(classesMissed*100) / (100 - attendancePercentage))
    }
    
    
}


struct AttendanceDetails: View {
    var attendanceSummary: [StudentAttdsummarylist]
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            ScrollView {
                AttendanceSummarySheet(data: attendanceSummary)
            }
        }
    }
}

struct AttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceView(studentid: "00012002467", token: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI2ZVBZc1ZZQWtQTnpLRCtQd2JTOFVBPT0iLCJzY29wZXMiOlt7ImF1dGhvcml0eSI6IlJPTEVfU1RVREVOVCJ9XSwiaXNzIjoiaHR0cDovL2NhbXB1c2x5bnguY29tIiwiaWF0IjoxNjgxMjE3NzMwLCJleHAiOjE2ODEzMDc3MzB9.2W041cGTpRp3gxLxniTrDuDPzHCcvd1lIRA_HgpUYXY")
    }
}
