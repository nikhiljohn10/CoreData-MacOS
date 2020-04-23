//
//  DataModel.swift
//  CoreData-MacOS
//
//  Created by Nikhil John on 22/04/20.
//  Copyright © 2020 Nikz.in. All rights reserved.
//

import Foundation
import CoreData

class DataModel {
    var context: NSManagedObjectContext
    let sort = NSSortDescriptor(key: "name", ascending: true)
    init(_ moc: NSManagedObjectContext) {
        self.context = moc
    }
    
    func addStudent(name: String) -> [Student] {
        let text = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if text != "" {
            let student = Student(context: self.context)
            student.name = text
            self.context.insert(student)
            self.save()
        }
        return self.getStudents()
    }
    
    func getStudents(withName name: String = "*") -> [Student] {
        let request = Student.fetchRequest() as NSFetchRequest<Student>
        request.sortDescriptors = [sort]
        if name != "*" {
            request.predicate = NSPredicate(format: "name CONTAINS %@", name)
        }
        do {
            return try self.context.fetch(request)
        } catch {
            fatalError("Error: Unable to get data")
        }
    }
    
    func delete(student: Student) -> [Student] {
        self.context.delete(student)
        self.save()
        return self.getStudents()
    }
    
    func deleteStudents(withName name: String = "*") -> [Student] {
        let fetchRequest = Student.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
        if name != "*" {
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS %@", name)
        }
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try self.context.execute(deleteRequest)
            self.save()
        } catch {
            fatalError("Error: Unable to delete")
        }
        return self.getStudents()
    }
    
    func save() {
        do {
            try self.context.save()
        } catch {
            fatalError("Error: Unable to save")
        }
    }
    
}
