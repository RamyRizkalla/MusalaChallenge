//
//  DomainModel.swift
//  MusalaWeather
//
//  Created by Ramy Rizkalla on 02/02/2022.
// Copyright © 2022 Musala. All rights reserved.
//

import Foundation

protocol DomainModel {
    associatedtype DomainModelType

    var domainModel: DomainModelType { get }
}
