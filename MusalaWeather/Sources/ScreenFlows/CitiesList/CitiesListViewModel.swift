// Copyright © 2022 Musala. All rights reserved.

import Foundation

class CitiesListViewModel {
    private var repository: CityLocalRepository
    private(set) var citiesList: [CityDomainModel] = []

    init() {
        repository = CityLocalRepository()
    }


    func fetchCities(completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.fetchAll { result in
            switch result {
            case let .success(citiesList):
                self.citiesList = citiesList
                completion(.success(true))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
