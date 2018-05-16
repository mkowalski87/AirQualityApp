//
//  Sensor+CoreDataProperties.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 28.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//
//

import Foundation
import CoreData


extension Sensor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sensor> {
        return NSFetchRequest<Sensor>(entityName: "Sensor")
    }

    @NSManaged public var id: Int
    @NSManaged public var paramCode: String
    @NSManaged public var paramFormula: String
    @NSManaged public var paramName: String
    @NSManaged public var station: Station?
    @NSManaged public var values: NSSet?

}

// MARK: Generated accessors for values
extension Sensor {

    @objc(addValuesObject:)
    @NSManaged public func addToValues(_ value: SensorValue)

    @objc(removeValuesObject:)
    @NSManaged public func removeFromValues(_ value: SensorValue)

    @objc(addValues:)
    @NSManaged public func addToValues(_ values: NSSet)

    @objc(removeValues:)
    @NSManaged public func removeFromValues(_ values: NSSet)

}
