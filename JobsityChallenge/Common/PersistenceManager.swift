//
//  PersistenceManager.swift
//  JobsityChallenge
//
//  Created by Marcelo José on 24/04/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import CoreData

class PersistenceManager: NSObject {

    static let sharedInstance = PersistenceManager()

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "JobsityChallenge")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("saved successfully")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetchFavorites(sortBy: String, ascending: Bool) -> [Favorites]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Favorites.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: sortBy, ascending: ascending)]

        do {
            if let fetchedObjects = try persistentContainer.viewContext.fetch(fetchRequest) as? [Favorites] {
                return fetchedObjects
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }

    func fetchFavoriteById(id: Int64) -> Favorites? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Favorites.self))
        fetchRequest.predicate = NSPredicate(format: "id = %lld", id)

        do {
            if let fetchedObjects = try persistentContainer.viewContext.fetch(fetchRequest).first as? Favorites {
                return fetchedObjects
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
