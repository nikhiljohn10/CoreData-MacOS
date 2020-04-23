//
//  ContentView.swift
//  CoreData-MacOS
//
//  Created by Nikhil John on 22/04/20.
//  Copyright © 2020 Nikz.in. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var students = [Student]()
    @State private var name: String = ""
    var body: some View {
        let model = DataModel(self.moc)
        return VStack{
            HStack {
                TextField("Name", text: self.$name, onCommit: {
                    self.students = model.addStudent(name: self.name)
                    self.name = ""
                })
                Button("Add") {
                    self.students = model.addStudent(name: self.name)
                    self.name = ""
                }
                Button("Delete") {
                    self.students = model.deleteStudents(withName: self.name)
                    self.name = ""
                }
                Button("Find") {
                    self.students = model.getStudents(withName: self.name)
                    self.name = ""
                }
            }
            List {
                ForEach(self.students, id: \.self){ student in
                    HStack {
                        Text(student.name ?? "Unknown")
                        Spacer()
                        Button("Delete"){
                            self.students = model.delete(student: student)
                        }
                    }
                }
                
            }
        }
        .padding(4)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear{
            self.students = model.getStudents()
        }
    }
}
