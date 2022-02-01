//
//  ConsolidatedWeather.swift
//  MusalaWeather
//
//  Created by Ramy Rizkalla on 02/02/2022.
// Copyright © 2022 Musala. All rights reserved.
//

import Foundation

struct ConsolidatedWeather: Codable {
    let id: Int
    let weatherStateName, weatherStateAbbr, windDirectionCompass, created: String
    let applicableDate: String
    let minTemp, maxTemp, theTemp, windSpeed: Double
    let windDirection, airPressure: Double
    let humidity: Int
    let visibility: Double
    let predictability: Int
}

extension ConsolidatedWeather: DomainModel {
    var domainModel: ConsolidatedWeatherDomainModel {
        ConsolidatedWeatherDomainModel(
            weatherStateName: weatherStateName,
            weatherStateAbbr: weatherStateAbbr,
            windDirectionCompass: windDirectionCompass,
            created: created,
            applicableDate: applicableDate,
            minTemp: minTemp,
            maxTemp: maxTemp,
            theTemp: theTemp,
            windSpeed: windSpeed,
            windDirection: windDirection,
            airPressure: airPressure,
            humidity: humidity,
            visibility: visibility,
            predictability: predictability
        )
    }
}
