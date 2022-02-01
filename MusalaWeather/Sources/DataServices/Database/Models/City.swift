// Copyright © 2022 Musala. All rights reserved.

import CoreData

@objc(City)
public class City: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
}

extension City: DomainModel {
    var domainModel: CityDomainModel {
        var domainModel: CityDomainModel!
        managedObjectContext?.performAndWait {
            domainModel = CityDomainModel(id: id, name: name)
        }
        return domainModel
    }
}
