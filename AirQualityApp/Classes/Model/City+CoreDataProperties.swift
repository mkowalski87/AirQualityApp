//
//  City+CoreDataProperties.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 12.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String

}
