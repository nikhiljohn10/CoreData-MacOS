//
//  Student+CoreDataProperties.swift
//  CoreData-MacOS
//
//  Created by Nikhil John on 22/04/20.
//  Copyright © 2020 Nikz.in. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Student)
public class Student: NSManagedObject {

}

extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        let request = NSFetchRequest<Student>(entityName: "Student")
        request.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        return request
    }
    
    @nonobjc public class func getAllStudents(_ context: NSManagedObjectContext) -> [Student] {
        do {
            return try context.fetch(self.fetchRequest() as NSFetchRequest<Student>)
        } catch {
            fatalError("Error: Unable to get data")
        }
    }

    @NSManaged public var name: String?

}
