//
//  StudentsList.swift
//  CoreData-MacOS
//
//  Created by Nikhil John on 23/04/20.
//  Copyright © 2020 Nikz.in. All rights reserved.
//

import SwiftUI

struct StudentsList: View {
    @EnvironmentObject var model: DataModel
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Student Name")
                Spacer()
                Divider().frame(height:20)
                Text("Action").frame(width: 60)
            }
            .padding(5)
            .padding([.leading,.trailing],5)
            .background(Color.gray.opacity(0.3))
            List {
                ForEach(self.model.students, id: \.id){ student in
                    StudentRow(student: student)
                }
            }
        }.cornerRadius(4)
    }
}
