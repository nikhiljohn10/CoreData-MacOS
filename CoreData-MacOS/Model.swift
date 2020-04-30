//
//  Model.swift
//  CoreData-MacOS
//
//  Created by Nikhil John on 22/04/20.
//  Copyright © 2020 Nikz.in. All rights reserved.
//

import SwiftUI

extension Student {
    var wrappedName: String {
        get { name ?? "Unknown Student" }
        set { name = newValue }
    }
    
    var wrappedRoll: String {
        get { roll ?? "000000" }
        set { roll = newValue }
    }
    
    var wrappedGPA: Float {
        get { gpa }
        set { gpa = Float(newValue) }
    }
}

class Model: ObservableObject {
    @Published var context: NSManagedObjectContext
    
    // App Data
    @Published var students: [Student] = [Student]()
    @Published var selection: Student? = nil
    @Published var name: String = ""
    @Published var saved: Bool = false
    var floatFormat: NumberFormatter {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        return format
    }
    
    init(_ context: NSManagedObjectContext) {
        self.context = context
        self.getStudents()
    }
    
    func getStudents() {
        let request = Student.fetchRequest() as NSFetchRequest<Student>
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        let text = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
        if text != "" {
            request.predicate = NSPredicate(format: "name CONTAINS %@", text)
        }
        do {
            self.students = try self.context.fetch(request)
        } catch {
            fatalError("Error: Unable to get data")
        }
    }
    
    func addStudent() {
        let text = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
        if text != "" {
            let student = Student(context: self.context)
            student.roll = "\(Int.random(in: 0...9))\(Int.random(in: 0...9))\(Int.random(in: 0...9))\(Int.random(in: 0...9))\(Int.random(in: 0...9))\(Int.random(in: 0...9))"
            student.name = text
            student.gpa = Float.random(in: 2.0...4.8)
            self.context.insert(student)
            self.save()
            self.name = ""
            self.getStudents()
        }
    }
    
    func deleteStudent(student: Student) {
        self.context.delete(student)
        self.save()
        self.getStudents()
        self.selection = nil
    }
    
    func deleteStudents() {
        let fetchRequest = Student.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
        if self.name != "" {
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS %@", self.name)
        }
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try self.context.execute(deleteRequest)
            self.save()
            self.name = ""
            self.selection = nil
            self.getStudents()
        } catch {
            fatalError("Error: Unable to delete")
        }
    }
    
    func save() {
        if self.context.hasChanges {
            do {
                self.saved.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.saved.toggle()
                }
                try self.context.save()
            } catch {
                let nserror = error as NSError
                NSApplication.shared.presentError(nserror)
            }
        }
    }
}
