//
//  CoreDataHelper.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 12.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelper {
    static let instance = CoreDataHelper()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AirQualityApp")
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: container.managedObjectModel)

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    var privateContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }

    func save(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print(error)
            }
        }
    }

}
