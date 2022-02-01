// Copyright © 2022 Musala. All rights reserved.

import Foundation

class ApiManager {
    static let shared = ApiManager()
    private let baseUrlString = Environment.baseUrl

    func fetchWeatherForecast(woeid: String, completion: @escaping (Result<WeatherApiResponse, Error>) -> Void) {
        let url = URL(string: "\(baseUrlString)/location/\(woeid)")!
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                self?.decodeWeatherResponse(data, completion: completion)
            }
        }
        task.resume()
    }

    private func decodeWeatherResponse(_ data: Data, completion: @escaping (Result<WeatherApiResponse, Error>) -> Void) {
        do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            let weatherResponse = try jsonDecoder.decode(WeatherApiResponse.self, from: data)
            completion(.success(weatherResponse))
        } catch let error {
            completion(.failure(error))
        }
    }

    func fetchIcon(state: String) -> Data? {
        let imageUrlPath = "\(Environment.rootUrl)/static/img/weather/png/64/\(state).png"
        let imageUrl = URL(string: imageUrlPath)!
        return try? Data(contentsOf: imageUrl)
    }
}
