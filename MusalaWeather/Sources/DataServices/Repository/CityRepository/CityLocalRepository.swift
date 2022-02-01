//
//  CityLocalRepository.swift
//  MusalaWeather
//
//  Created by Ramy Rizkalla on 03/02/2022.
// Copyright © 2022 Musala. All rights reserved.
//

import Foundation

class CityLocalRepository: CityRepository {
    private let repository: CoreDataRepository<City>

    init() {
        repository = CoreDataRepository(managedObjectContext: CoreDataManager.default.privateManagedObjectContext)
    }

    func fetchAll(completion: @escaping (Result<[CityDomainModel], Error>) -> Void) {
        let result = repository.fetch()
        switch result {
        case let .success(weather):
            completion(.success(weather.map { $0.domainModel }))
        case let .failure(error):
            completion(.failure(error))
        }
    }

    func save(cites: [CityDomainModel]) {
        cites.forEach { saveCity($0) }
        repository.saveContext()
    }

    private func saveCity(_ city: CityDomainModel) {
        let result = repository.create()
        if case let .success(cityCoreDataModel) = result {
            cityCoreDataModel.id = city.id
            cityCoreDataModel.name = city.name
        }
    }
}
