// Copyright © 2022 Musala. All rights reserved.

import Foundation
import CoreData

@objc(Weather)
public class Weather: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var cityId: String
    @NSManaged public var title: String
    @NSManaged public var currentDate: Date
    @NSManaged public var sunriseTime: Date
    @NSManaged public var sunsetTime: Date
    @NSManaged public var consolidatedWeatherMO: [ConsolidatedWeatherMO]?
}

extension Weather: DomainModel {
    var domainModel: WeatherDomainModel {
        var domainModel: WeatherDomainModel!
        var consolidatedWeatherList = [ConsolidatedWeatherDomainModel]()
        managedObjectContext?.performAndWait {
            consolidatedWeatherMO?.forEach {
                consolidatedWeatherList.append(consolidatedWeatherDomainModel(from: $0))
            }
            domainModel = WeatherDomainModel(
                title: title,
                consolidatedWeather: consolidatedWeatherList,
                currentDate: currentDate,
                sunriseTime: sunriseTime,
                sunsetTime: sunsetTime
            )
        }
        return domainModel
    }

    private func consolidatedWeatherDomainModel(from consolidatedWeatherMO: ConsolidatedWeatherMO) -> ConsolidatedWeatherDomainModel {
        return ConsolidatedWeatherDomainModel(
            weatherStateName: consolidatedWeatherMO.weatherStateName,
            weatherStateAbbr: consolidatedWeatherMO.weatherStateAbbr,
            windDirectionCompass: consolidatedWeatherMO.windDirectionCompass,
            created: consolidatedWeatherMO.created,
            applicableDate: consolidatedWeatherMO.applicableDate,
            minTemp: consolidatedWeatherMO.minTemp,
            maxTemp: consolidatedWeatherMO.maxTemp,
            theTemp: consolidatedWeatherMO.theTemp,
            windSpeed: consolidatedWeatherMO.windSpeed,
            windDirection: consolidatedWeatherMO.windDirection,
            airPressure: consolidatedWeatherMO.airPressure,
            humidity: consolidatedWeatherMO.humidity,
            visibility: consolidatedWeatherMO.visibility,
            predictability: consolidatedWeatherMO.predictability
        )
    }
}
