//
//  StudentRow.swift
//  CoreData-MacOS
//
//  Created by Nikhil John on 23/04/20.
//  Copyright © 2020 Nikz.in. All rights reserved.
//

import SwiftUI

struct StudentRow: View {
    var student: Student
    @EnvironmentObject var model: DataModel
    @State private var selected: Bool = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(self.selected ? Color.gray.opacity(0.2) : Color.clear)
                .scaleEffect(1.5)
                .onHover(perform: { hover in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        self.selected = hover
                    }
                })
            HStack {
                Text(self.student.name ?? "Unknown")
                Spacer()
                Button("Delete"){
                    self.model.deleteStudent(student: self.student)
                }.frame(width: 60)
            }
        }
    }
}
