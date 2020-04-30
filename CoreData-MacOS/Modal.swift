//
//  Modal.swift
//  CoreData-MacOS
//
//  Created by Nikhil John on 30/04/20.
//  Copyright © 2020 Nikz.in. All rights reserved.
//

import SwiftUI

struct ModalView: View {
    @EnvironmentObject var model: Model
    @Binding var showModal: Bool
    @ObservedObject var student: Student
    @State private var fval: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Student Name")
                TextField("", text: $student.wrappedName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Student GPA")
                Slider(value: self.$student.wrappedGPA, in: 0...5, step: 0.1)
                Text("\(self.student.wrappedGPA, specifier: "%.1f")").frame(width: 30)
            }
            Spacer()
            HStack {
                Spacer()
                Button("Cancel") {
                    self.showModal.toggle()
                }
                Button("Save") {
                    self.model.save()
                    self.showModal.toggle()
                }
            }.frame(width: 300)
        }.padding()
    }
}
