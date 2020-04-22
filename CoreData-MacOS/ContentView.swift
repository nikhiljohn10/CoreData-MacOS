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
        let data = DataModel(self.moc)
        return VStack{
            HStack {
                TextField("Name", text: self.$name, onCommit: {
                    if self.name.count>0 {
                        self.students = try! data.insertStudent(name: self.name)
                        self.name = ""
                    }
                })
                Button("Add") {
                    if self.name.count>0 {
                        self.students = try! data.insertStudent(name: self.name)
                        self.name = ""
                    }
                }
                Button("Delete All") {
                    self.students = try! data.deleteAll()
                }
            }
            List {
                ForEach(self.students, id: \.self){ student in
                    HStack {
                        Text(student.name ?? "Unknown")
                        Button("Delete"){
                            self.students = try! data.delete(student: student)
                        }
                    }
                }
                
            }
        }
        .padding(4)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear{
            self.students = try! data.fetchStudents()
        }
    }
}
