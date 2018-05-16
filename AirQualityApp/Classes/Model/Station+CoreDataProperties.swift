//
//  Station+CoreDataProperties.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 27.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//
//

import Foundation
import CoreData


extension Station {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Station> {
        return NSFetchRequest<Station>(entityName: "Station")
    }

    @NSManaged public var coordLat: Double
    @NSManaged public var coordLon: Double
    @NSManaged public var favourite: Bool
    @NSManaged public var id: Int
    @NSManaged public var stationName: String
    @NSManaged public var street: String?
    @NSManaged public var city: City
    @NSManaged public var qualityIndexes: NSSet?
    @NSManaged public var sensors: NSSet?

}

// MARK: Generated accessors for qualityIndexes
extension Station {

    @objc(addQualityIndexesObject:)
    @NSManaged public func addToQualityIndexes(_ value: QualityIndex)

    @objc(removeQualityIndexesObject:)
    @NSManaged public func removeFromQualityIndexes(_ value: QualityIndex)

    @objc(addQualityIndexes:)
    @NSManaged public func addToQualityIndexes(_ values: NSSet)

    @objc(removeQualityIndexes:)
    @NSManaged public func removeFromQualityIndexes(_ values: NSSet)

}

// MARK: Generated accessors for sensors
extension Station {

    @objc(addSensorsObject:)
    @NSManaged public func addToSensors(_ value: Sensor)

    @objc(removeSensorsObject:)
    @NSManaged public func removeFromSensors(_ value: Sensor)

    @objc(addSensors:)
    @NSManaged public func addToSensors(_ values: NSSet)

    @objc(removeSensors:)
    @NSManaged public func removeFromSensors(_ values: NSSet)

}
