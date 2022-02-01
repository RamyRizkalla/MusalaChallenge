//
//  CityRepository.swift
//  MusalaWeather
//
//  Created by Ramy Rizkalla on 03/02/2022.
// Copyright © 2022 Musala. All rights reserved.
//

import Foundation

protocol CityRepository {
    func fetchAll(completion: @escaping (Result<[CityDomainModel], Error>) -> Void)
    func save(cites: [CityDomainModel])
}
