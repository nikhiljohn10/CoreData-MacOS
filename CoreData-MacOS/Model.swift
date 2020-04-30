//
//  Model.swift
//  CoreData-MacOS
//
//  Created by Nikhil John on 22/04/20.
//  Copyright © 2020 Nikz.in. All rights reserved.
//

import SwiftUI

class Model: ObservableObject {
    @Published var context: NSManagedObjectContext
    
    // App Data
    @Published var students: [Student] = [Student]()
    @Published var selection: Student? = nil
    @Published var name: String = ""
    
    
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
        }
        self.resetTextField()
        self.getStudents()
    }
    
    func deleteStudent(student: Student) {
        self.context.delete(student)
        self.save()
        self.getStudents()
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
        } catch {
            fatalError("Error: Unable to delete")
        }
        self.resetTextField()
        self.getStudents()
    }
    
    func resetTextField() {
        self.name = ""
    }
    
    func save() {
        if self.context.hasChanges {
            do {
                try self.context.save()
            } catch {
                let nserror = error as NSError
                NSApplication.shared.presentError(nserror)
            }
        }
    }
    
}
