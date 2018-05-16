//
//  CityDAO.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 14.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import CoreData

class CityDAO {
    func saveOrUpdate(cityObj: CityCodable, context: NSManagedObjectContext) -> City {
        let city = get(id: cityObj.id, context: context) ?? City(context: context)
        city.id = cityObj.id
        city.name = cityObj.name
        return city
    }

    func get(id: Int32, context: NSManagedObjectContext) -> City? {
        let request = NSFetchRequest<City>(entityName: "City")
        request.predicate = NSPredicate(format: "id = %d", id)
        request.fetchLimit = 1
        if let results = try? context.fetch(request) {
            return results.first
        }
        return nil
    }

}
