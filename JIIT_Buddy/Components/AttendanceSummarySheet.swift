//
//  AttendanceSummarySheet.swift
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 14/04/23.
//

import SwiftUI






struct AttendanceSummarySheet: View {
    let data : [StudentAttdsummarylist]
        

        var body: some View {
            List(data, id: \.datetime) { item in
                HStack {
                    Text(item.datetime)
                    Spacer()
                    Text(item.attendanceby)
                    Spacer()
                    Text(item.classtype.rawValue)
                    Spacer()
                    Text(item.present)
                }.listRowBackground(Color.clear)
            }
        }
}

struct AttendanceSummarySheet_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceSummarySheet(data: [StudentAttdsummarylist(attendanceby: "AN", classtype: Classtype.regular, datetime: "10/23", present: "Present")])
    }
}
