//
//  CoreDataRespository.swift
//  MusalaWeather
//
//  Created by Ramy Rizkalla on 02/02/2022.
// Copyright © 2022 Musala. All rights reserved.
//

import Foundation
import CoreData


/// Enum for CoreData related errors
enum CoreDataError: Error {
    case invalidManagedObjectType
}

/// Generic class for handling NSManagedObject subclasses.
class CoreDataRepository<T: NSManagedObject>: Repository {
    typealias Entity = T

    /// The NSManagedObjectContext instance to be used for performing the operations.
    let managedObjectContext: NSManagedObjectContext

    /// Designated initializer.
    /// - Parameter managedObjectContext: The NSManagedObjectContext instance to be used for performing the operations.
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }

    func create() -> Result<Entity, Error> {
        let className = String(describing: Entity.self)
        guard let managedObject = NSEntityDescription.insertNewObject(forEntityName: className, into: managedObjectContext) as? Entity else {
            return .failure(CoreDataError.invalidManagedObjectType)
        }
        return .success(managedObject)
    }

    func delete(entity: Entity) {
        managedObjectContext.delete(entity)
    }

    @discardableResult
    func batchDelete() -> Result<Bool, Error> {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: Entity.fetchRequest())
        deleteRequest.resultType = .resultTypeObjectIDs

        do {
            let batchDelete = try managedObjectContext.execute(deleteRequest) as? NSBatchDeleteResult
            guard let deleteResult = batchDelete?.result as? [NSManagedObjectID] else { return .failure(CoreDataError.invalidManagedObjectType) }
            let deletedObjects: [AnyHashable: Any] = [ NSDeletedObjectsKey: deleteResult]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: deletedObjects, into: [managedObjectContext])
            return .success(true)
        } catch {
            return .failure(error)
        }
    }

    func fetchFirst(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> Result<T?, Error> {
        let result = fetch(predicate: predicate, sortDescriptors: sortDescriptors)
        switch result {
        case let .success(items):
            return .success(items.first)
        case let .failure(error):
            return .failure(error)
        }
    }

    func fetch(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> Result<[Entity], Error> {
        let fetchRequest = Entity.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        do {
            if let fetchResults = try managedObjectContext.fetch(fetchRequest) as? [Entity] {
                return .success(fetchResults)
            } else {
                return .failure(CoreDataError.invalidManagedObjectType)
            }
        } catch {
            return .failure(error)
        }
    }

    func count(predicate: NSPredicate? = nil) -> Result<Int, Error> {
        let fetchRequest = Entity.fetchRequest()
        do {
            let count = try managedObjectContext.count(for: fetchRequest)
            return .success(count)
        } catch {
            return .failure(error)
        }
    }

    func saveContext() {
        CoreDataManager.default.saveContext(managedObjectContext)
    }
}
