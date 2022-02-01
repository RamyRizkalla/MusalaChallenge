// Copyright © 2022 Musala. All rights reserved.

import CoreData

final class CoreDataManager {
    static var `default` = CoreDataManager(modelName: "MusalaWeather")

    private let modelName: String
    private let notificationCenter = NotificationCenter.default

    lazy var persistentContainer: NSPersistentContainer = {
        guard let modelURL = Bundle(for: CoreDataManager.self).url(forResource: modelName, withExtension:"momd") else {
                fatalError("Error loading model from bundle")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }

        let container = NSPersistentContainer(name: modelName, managedObjectModel: managedObjectModel)

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()

    private(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    var privateManagedObjectContext: NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        return context
    }

    init(modelName: String) {
        self.modelName = modelName
    }

    func saveContext(_ context: NSManagedObjectContext) {
        let observer = notificationCenter.addObserver(forName: .NSManagedObjectContextDidSave, object: context, queue: .main) { notification in
            self.mainManagedObjectContext.mergeChanges(fromContextDidSave: notification)
        }

        context.performAndWait {
            try? context.save()
        }
        NotificationCenter.default.removeObserver(observer)
    }
}
