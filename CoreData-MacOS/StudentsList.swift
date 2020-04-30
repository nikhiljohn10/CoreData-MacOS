//
//  StudentsList.swift
//  CoreData-MacOS
//
//  Created by Nikhil John on 23/04/20.
//  Copyright © 2020 Nikz.in. All rights reserved.
//

import SwiftUI

struct StudentsList: View {
    @EnvironmentObject var model: Model
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("ID").frame(width: 60)
                Divider().frame(height:20)
                Text("Student Name").padding(.leading,5)
                Spacer()
                Divider().frame(height:20)
                Text("GPA").frame(width: 60)
            }
            .padding(5)
            .padding([.leading,.trailing],5)
            .background(Color.gray.opacity(0.3))
            List(selection: self.$model.selection) {
                ForEach(self.model.students, id: \.self){ student in
                    StudentRow(student: student).tag(student)
                }
                .onMove(perform: { source, destination in
                    self.model.students.move(fromOffsets: source, toOffset: destination)
                })
            }
            .onDeleteCommand(perform: {
                if let std = self.model.selection {
                    self.model.deleteStudent(student: std)
                }
            })
        }.cornerRadius(4)
    }
}
