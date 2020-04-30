//
//  StatusBar.swift
//  CoreData-MacOS
//
//  Created by Nikhil John on 30/04/20.
//  Copyright © 2020 Nikz.in. All rights reserved.
//

import SwiftUI

struct StatusBar: View {
    @EnvironmentObject var model: Model
    var body: some View {
        HStack {
            Text("Total Students:")
            Text("\(self.model.students.count)")
            Divider().frame(height: 15)
            Text( "\(self.model.selection?.name ?? "Unknown")" )
            Spacer()
            Divider().frame(height: 15)
            Text( "\(self.model.selection?.wrappedGPA ?? 0.0, specifier: "%.1f")" )
                .frame(width: 30)
            Divider().frame(height: 15)
            Text( self.model.saved ? "Saving" : "Saved" ).frame(width: 50)
        }.padding([.bottom, .horizontal],5)
    }
}
