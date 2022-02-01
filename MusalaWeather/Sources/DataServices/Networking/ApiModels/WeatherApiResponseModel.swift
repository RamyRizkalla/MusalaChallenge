// Copyright © 2022 Musala. All rights reserved.

import Foundation

struct WeatherApiResponse: Decodable {
    let consolidatedWeather: [ConsolidatedWeather]
    let time, sunRise, sunSet: Date
    let timezoneName: String
    let title, locationType: String
    let woeid: Int
    let lattLong, timezone: String
}

extension WeatherApiResponse: DomainModel {
    var domainModel: WeatherDomainModel {
        return WeatherDomainModel(
            title: title,
            consolidatedWeather: consolidatedWeather.map { $0.domainModel },
            currentDate: time,
            sunriseTime: sunRise,
            sunsetTime: sunSet
        )
    }
}
