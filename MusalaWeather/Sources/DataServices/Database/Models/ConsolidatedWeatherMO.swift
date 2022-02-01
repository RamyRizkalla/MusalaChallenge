// Copyright © 2022 Musala. All rights reserved.

import Foundation
import CoreData

@objc(ConsolidatedWeatherMO)
public class ConsolidatedWeatherMO: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConsolidatedWeatherMO> {
        return NSFetchRequest<ConsolidatedWeatherMO>(entityName: "ConsolidatedWeatherMO")
    }

    @NSManaged public var weatherStateName: String
    @NSManaged public var weatherStateAbbr: String
    @NSManaged public var windDirectionCompass: String
    @NSManaged public var created: String
    @NSManaged public var applicableDate: String
    @NSManaged public var minTemp: Double
    @NSManaged public var maxTemp: Double
    @NSManaged public var theTemp: Double
    @NSManaged public var windSpeed: Double
    @NSManaged public var windDirection: Double
    @NSManaged public var airPressure: Double
    @NSManaged public var humidity: Int
    @NSManaged public var visibility: Double
    @NSManaged public var predictability: Int
}
