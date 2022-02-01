//
//  Repository.swift
//  MusalaWeather
//
//  Created by Ramy Rizkalla on 02/02/2022.
// Copyright © 2022 Musala. All rights reserved.
//

import Foundation

protocol Repository {
    associatedtype Entity

    func create() -> Result<Entity, Error>
    func delete(entity: Entity)
    func batchDelete() -> Result<Bool, Error>
    func fetch(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[Entity], Error>
    func fetchFirst(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<Entity?, Error>
    func count(predicate: NSPredicate?) -> Result<Int, Error>
}
