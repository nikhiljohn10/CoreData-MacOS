//
//  StudentRow.swift
//  CoreData-MacOS
//
//  Created by Nikhil John on 23/04/20.
//  Copyright © 2020 Nikz.in. All rights reserved.
//

import SwiftUI

struct StudentRow: View {
    @ObservedObject var student: Student
    @EnvironmentObject var model: Model
    @State private var selected: Bool = false
    var body: some View {
        HStack {
            Text(self.student.name ?? "Unknown")
            Spacer()
            Button("Delete"){
                self.model.deleteStudent(student: self.student)
            }.frame(width: 60)
        }
    }
}
