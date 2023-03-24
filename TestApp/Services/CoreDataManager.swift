//
//  CoreDataManager.swift
//  StackLock
//
//  Created by Анастасия Хурдаян on 13.03.2023.
//

import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TestApp")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func getData<T: NSManagedObject>(from: T.Type, predicate: NSPredicate? = nil ,handler: (_ success: Bool, _ result: [T], _ error: NSError?) -> ()) {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        do {
            let objects = try persistentContainer.viewContext.fetch(fetchRequest)
            handler(true, objects, nil)
        } catch let error as NSError {
            handler(false, [], error)
        }
    }
    
    func save(_ handler: ((_ success: Bool) -> ())? = nil) {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
                handler?(true)
            } catch let error as NSError {
                print(error.localizedDescription, "CoreData Save Error")
                handler?(false)
            }
        }
    }
    
    func delete<T: NSManagedObject>(_ object: T, _ completion: ((_ success: Bool) -> ())? = nil) {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        if let _ = try? persistentContainer.viewContext.fetch(fetchRequest) {
            persistentContainer.viewContext.delete(object)
        }

        do {
            try persistentContainer.viewContext.save()
            completion?(true)
        } catch let error as NSError {
            print(error.localizedDescription)
            completion?(false)
        }
    }
}
