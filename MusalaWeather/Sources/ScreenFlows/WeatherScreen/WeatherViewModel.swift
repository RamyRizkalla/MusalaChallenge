// Copyright © 2022 Musala. All rights reserved.

import Foundation

class WeatherViewModel {
    private let l10n = L10n.Weather.Details.self
    private(set) var weatherDetails: ConsolidatedWeatherDomainModel
    private(set) var cityWeather: WeatherDomainModel

    init(weatherDetails: ConsolidatedWeatherDomainModel, cityWeather: WeatherDomainModel) {
        self.weatherDetails = weatherDetails
        self.cityWeather = cityWeather
    }

    func cellData(weatherDataType: WeatherDetailType) -> ViewData {
        switch weatherDataType {
        case .overview:
            return WeatherOverviewCellData(
                city: cityWeather.title,
                description: weatherDetails.weatherStateName,
                temperature: weatherDetails.theTemp.formattedStringValue.appending("°"),
                maxTemperature: weatherDetails.maxTemp.formattedStringValue,
                minTemperature: weatherDetails.minTemp.formattedStringValue
            )
        case .windAndAirPressure:
            return WeatherDetailsCellData(
                leftHeader: l10n.Headers.wind,
                leftInfo: weatherDetails.windSpeed.formattedStringValue.appending(" KM/H"),
                rightHeader: l10n.Headers.airPressure,
                rightInfo: weatherDetails.airPressure.formattedStringValue
            )
        case .humidityAndVisibility:
            return WeatherDetailsCellData(
                leftHeader: l10n.Headers.visibility,
                leftInfo: weatherDetails.visibility.formattedStringValue,
                rightHeader: l10n.Headers.wind,
                rightInfo: weatherDetails.humidity.stringValue.appending("%")
            )
        }
    }
}
