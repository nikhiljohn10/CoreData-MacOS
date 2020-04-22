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
    
    func insertStudent(name: String) throws -> [Student] {
        let student = Student(context: self.context)
        student.name = name
        self.context.insert(student)
        try self.context.save()
        return try! self.fetchStudents()
    }
    
    func fetchStudents() throws -> [Student] {
        let students = try self.context.fetch(Student.fetchRequest() as NSFetchRequest<Student>)
        return students
    }
    
    func fetchStudents(withName name: String) throws -> [Student] {
        let request = NSFetchRequest<Student>(entityName: "Student")
        request.sortDescriptors = [sort]
        request.predicate = NSPredicate(format: "name == %@", name)
        
        let students = try self.context.fetch(request)
        return students
    }
    
    func delete(student: Student) throws -> [Student] {
        self.context.delete(student)
        try self.context.save()
        return try! self.fetchStudents()
    }
    
    func deleteStudents(withName name: String) throws -> [Student] {
        let fetchRequest = Student.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try self.context.execute(deleteRequest)
        try self.context.save()
        return try! self.fetchStudents()
    }
    
    func  deleteAll() throws -> [Student] {
        let students = try! self.fetchStudents()
        for student in students{
            self.context.delete(student)
            try self.context.save()
        }
        return try! self.fetchStudents()
    }
    
}
