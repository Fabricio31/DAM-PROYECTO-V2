//
//  Student+CoreDataProperties.swift
//  ProyectoV2
//
//  Created by BigSur on 13/11/23.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var std: String?
    @NSManaged public var name: String?
    @NSManaged public var school: String?

}

extension Student : Identifiable {

}
