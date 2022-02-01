//
//  ConsolidatedWeatherDomainModel.swift
//  MusalaWeather
//
//  Created by Ramy Rizkalla on 02/02/2022.
//  Copyright © 2022 Ramy Rizkalla. All rights reserved.
//

import Foundation

struct ConsolidatedWeatherDomainModel {
    let weatherStateName: String
    let weatherStateAbbr: String
    let windDirectionCompass: String
    let created: String
    let applicableDate: String
    let minTemp: Double
    let maxTemp: Double
    let theTemp: Double
    let windSpeed: Double
    let windDirection: Double
    let airPressure: Double
    let humidity: Int
    let visibility: Double
    let predictability: Int
}
