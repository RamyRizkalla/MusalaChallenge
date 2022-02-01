//
//  WeatherLocalRepository.swift
//  MusalaWeather
//
//  Created by Ramy Rizkalla on 02/02/2022.
// Copyright © 2022 Musala. All rights reserved.
//

import Foundation
import UIKit

class WeatherLocalRepository: WeatherRepository {
    private let repository: CoreDataRepository<Weather>

    init() {
        repository = CoreDataRepository(managedObjectContext: CoreDataManager.default.privateManagedObjectContext)
    }

    func fetchWeather(cityId: String, completion: @escaping (Result<WeatherDomainModel, Error>) -> Void) {
        let predicate = NSPredicate(format: "cityId == %@", cityId)
        let result = repository.fetchFirst(predicate: predicate)
        switch result {
        case let .success(weather):
            completion(.success(weather!.domainModel))
        case let .failure(error):
            completion(.failure(error))
        }
    }
}

extension WeatherLocalRepository: WeatherDataSavingRepository {
    @discardableResult
    func save(weatherData: WeatherDomainModel) -> Result<Bool, Error> {
        // TODO: To be implemented
        return .success(true)
    }
}
