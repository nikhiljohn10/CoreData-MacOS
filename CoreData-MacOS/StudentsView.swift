//
//  StudentsView.swift
//  CoreData-MacOS
//
//  Created by Nikhil John on 23/04/20.
//  Copyright © 2020 Nikz.in. All rights reserved.
//

import SwiftUI

struct StudentsView: View {
    @EnvironmentObject var model: DataModel
    var body: some View {
        VStack {
            HStack {
                TextField("Student Name", text: self.$model.name, onCommit: {
                    self.model.getStudents()
                })
                Button("Add") {
                    self.model.addStudent()
                }
                Button("Delete All") {
                    self.model.deleteStudents()
                }
                Button(action: {
                    self.model.getStudents()
                }){
                    if self.model.name == "" {
                        Text("Find All")
                    } else {
                        Text("Find")
                    }
                }
            }
            StudentsList()
        }.onAppear{
            self.model.getStudents()
        }
    }
}
