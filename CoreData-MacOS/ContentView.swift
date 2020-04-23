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
    var body: some View {
        StudentsView()
            .environmentObject(DataModel(self.moc))
            .padding(4)
            .frame(minWidth: 400, maxWidth: .infinity, minHeight: 200, maxHeight: .infinity)
    }
}
