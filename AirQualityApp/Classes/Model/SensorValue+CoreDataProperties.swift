//
//  SensorValue+CoreDataProperties.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 28.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//
//

import Foundation
import CoreData


extension SensorValue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SensorValue> {
        return NSFetchRequest<SensorValue>(entityName: "SensorValue")
    }

    @NSManaged public var date: String
    @NSManaged public var value: String
    @NSManaged public var sensor: Sensor?

}
