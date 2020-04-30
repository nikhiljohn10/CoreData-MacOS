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
            Text(self.student.roll ?? "000000").frame(width: 60)
            Text(self.student.name ?? "Unknown")
            Spacer()
            Text("\(self.student.gpa, specifier: "%.1f")").frame(width: 60)
        }
    }
}
