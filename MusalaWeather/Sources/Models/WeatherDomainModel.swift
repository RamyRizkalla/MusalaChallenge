// Copyright © 2022 Musala. All rights reserved.

import Foundation

struct WeatherDomainModel {
    var isDay: Bool {
        return currentDate > sunriseTime && currentDate < sunsetTime
    }

    let title: String
    let consolidatedWeather: [ConsolidatedWeatherDomainModel]
    let currentDate: Date
    let sunriseTime: Date
    let sunsetTime: Date
}
