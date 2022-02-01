//
//  L10n.swift
//  MusalaWeather
//
//  Created by Ramy Rizkalla on 01/02/2022.
//

import Foundation

enum L10n {
    enum Global {
        enum Labels {
            static let error = "global.labels.error".localized
        }

        enum Actions {
            static let ok = "global.actions.ok".localized
        }
    }

    enum Weather {
        enum Errors {
            static let parsingError = "weather.errors.parsing_error".localized
        }

        enum Details {
            enum Headers {
                static let visibility = "weather.details.headers.visibility".localized
                static let airPressure = "weather.details.headers.air_pressure".localized
                static let wind = "weather.details.headers.wind".localized
                static let humidity = "weather.details.headers.humidity".localized
            }
        }
    }
}
