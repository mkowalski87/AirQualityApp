//
//  StationDAO.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 12.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import CoreData

class StationDAO {
    func saveOrUpdate(stationObj: StationCodable, context: NSManagedObjectContext) -> Station {
        let station = get(id: stationObj.id, context: context) ??  Station(context: context)
        station.id = stationObj.id
        station.coordLat = Double(stationObj.gegrLat) ?? 0
        station.coordLon = Double(stationObj.gegrLon) ?? 0
        station.stationName = stationObj.stationName
        station.street = stationObj.addressStreet
        return station
    }

    func get(id: Int, context: NSManagedObjectContext) -> Station? {
        let request = NSFetchRequest<Station>(entityName: "Station")
        request.predicate = NSPredicate(format: "id = %d", id)
        request.fetchLimit = 1
        if let results = try? context.fetch(request) {
            return results.first
        }
        return nil
    }

    func all(context: NSManagedObjectContext) -> [Station] {
        let request = NSFetchRequest<Station>(entityName: "Station")
        if let results = try? context.fetch(request) {
            return results
        }
        return []
    }

    func search(with text: String, context: NSManagedObjectContext) -> [Station] {
        let request = NSFetchRequest<Station>(entityName: "Station")
        request.predicate = NSPredicate(format: "stationName CONTAINS %@", text)
        if let results = try? context.fetch(request) {
            return results
        }
        return []
    }

    func toggleFavourite(stationId: Int, context: NSManagedObjectContext) -> Station? {
        if let station = get(id: stationId, context: context) {
            station.favourite = !station.favourite
            return station
        }
        return nil
    }

    func allFavourites(context: NSManagedObjectContext) -> [Station] {
        let request = NSFetchRequest<Station>(entityName: "Station")
        request.predicate = NSPredicate(format: "favourite == true")
        request.sortDescriptors = [NSSortDescriptor(key: "stationName", ascending: true)]
        if let results = try? context.fetch(request) {
            return results
        }
        return []
    }
}
