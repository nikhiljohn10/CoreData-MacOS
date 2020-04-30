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
    @State private var edit = false
    @State private var showModal = false
    var body: some View {
        HStack {
            Text(self.student.wrappedRoll).frame(width: 60)
            HStack {
                Text(self.student.wrappedName)
                Spacer()
                if self.edit {
                    Button(action: {
                        self.model.selection = self.student
                        self.showModal.toggle()
                    }){
                        Text("Edit")
                        .padding(.horizontal, 10)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            Spacer()
            Text("\(self.student.wrappedGPA, specifier: "%.1f")").frame(width: 60)
        }.onHover(perform: {
            self.edit = $0
        })
        .sheet(isPresented: $showModal) {
            ModalView(showModal: self.$showModal, student: self.model.selection!)
                .environmentObject(self.model)
        }
    }
}
