//
//  WeatherDataRepository.swift
//  MusalaWeather
//
//  Created by Ramy Rizkalla on 02/02/2022.
// Copyright © 2022 Musala. All rights reserved.
//

import Foundation

class WeatherDataRepository: WeatherRepository {
    private let remoteDataSource: WeatherRepository
    private let localDataSource: WeatherRepository & WeatherDataSavingRepository

    init(
        remoteDataSource: WeatherRepository,
        localDataSource: WeatherRepository & WeatherDataSavingRepository
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    func fetchWeather(cityId: String, completion: @escaping (Result<WeatherDomainModel, Error>) -> Void) {
        remoteDataSource.fetchWeather(cityId: cityId) { [weak self] result in
            if case let .success(data) = result {
                self?.localDataSource.save(weatherData: data)
            }
            completion(result)
        }
    }
}
