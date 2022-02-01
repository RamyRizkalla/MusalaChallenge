//
//  WeatherRemoteRepository.swift
//  MusalaWeather
//
//  Created by Ramy Rizkalla on 02/02/2022.
// Copyright © 2022 Musala. All rights reserved.
//

import Foundation

class WeatherRemoteRepository: WeatherRepository {
    private let apiManager = ApiManager.shared

    func fetchWeather(cityId: String, completion: @escaping (Result<WeatherDomainModel, Error>) -> Void) {
        apiManager.fetchWeatherForecast(woeid: cityId) { result in
            switch result {
            case let .success(weatherData):
                let domainModel = weatherData.domainModel
                completion(.success(domainModel))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
