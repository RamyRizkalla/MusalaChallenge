// Copyright © 2022 Musala. All rights reserved.

import Foundation

class CityDetailsViewModel {
    private var repository: WeatherRepository
    private var cityId: String
    private(set) var weatherData: WeatherDomainModel?

    var numberOfDays: Int {
        return weatherData?.consolidatedWeather.count ?? 0
    }

    var cellData: [ConsolidatedWeatherDomainModel] {
        return weatherData?.consolidatedWeather ?? []
    }

    init(cityId: String) {
        let localRepository = WeatherLocalRepository()
        let remoteRepository = WeatherRemoteRepository()
        repository = WeatherDataRepository(remoteDataSource: remoteRepository, localDataSource: localRepository)
        self.cityId = cityId
    }

    func fetchWeatherDetails(completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.fetchWeather(cityId: cityId) { result in
            switch result {
            case let .success(weatherData):
                self.weatherData = weatherData
                completion(.success(true))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchIcon(for state: String, completion: @escaping (Data?) -> Void) {
        DispatchQueue.global().async {
            let data = ApiManager.shared.fetchIcon(state: state)
            completion(data)
        }
    }
}
