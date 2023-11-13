//
//  DBManager.swift
//  ProyectoV2
//
//  Created by BigSur on 13/11/23.
//

import UIKit
import CoreData

class DBManager{
    
    static let share = DBManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
      
        let container = NSPersistentContainer(name: "ProyectoV2")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    lazy var context = persistentContainer.viewContext
    func saveContext () {
       
        if context.hasChanges {
            do {
                try context.save()
            } catch {
             
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchStudent() -> [Student]{
        var student = [Student]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Student.description())
        do{
            student = try context.fetch(fetchRequest) as! [Student]
        }
        catch{
            print("fetching error")
        }
        return student
    }
    
}
