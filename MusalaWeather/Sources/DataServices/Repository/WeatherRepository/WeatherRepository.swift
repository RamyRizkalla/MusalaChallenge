//
//  WeatherRepository.swift
//  MusalaWeather
//
//  Created by Ramy Rizkalla on 02/02/2022.
// Copyright © 2022 Musala. All rights reserved.
//

import Foundation

protocol WeatherRepository {
    func fetchWeather(cityId: String, completion: @escaping (Result<WeatherDomainModel, Error>) -> ())
}

protocol WeatherDataSavingRepository {
    @discardableResult
    func save(weatherData: WeatherDomainModel) -> Result<Bool, Error>
}
