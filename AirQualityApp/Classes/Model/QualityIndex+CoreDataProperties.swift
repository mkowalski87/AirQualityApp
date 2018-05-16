//
//  QualityIndex+CoreDataProperties.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 15.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//
//

import Foundation
import CoreData


extension QualityIndex {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QualityIndex> {
        return NSFetchRequest<QualityIndex>(entityName: "QualityIndex")
    }

    @NSManaged public var id: Int64
    @NSManaged public var calcDate: String
    @NSManaged public var indexLevelName: String
    @NSManaged public var station: Station
    @NSManaged public var so2IndexLevel: String?
    @NSManaged public var so2SourceDataDate: String?
    @NSManaged public var noSourceDataDate: String?
    @NSManaged public var noIndexLevel: String?
    @NSManaged public var coSourceDataDate: String?
    @NSManaged public var coIndexLevel: String?
    @NSManaged public var pm10SourceDataDate: String?
    @NSManaged public var pm10IndexLevel: String?
    @NSManaged public var o3SourceDataDate: String?
    @NSManaged public var o3IndexLevel: String?
    @NSManaged public var c6h6SourceDataDate: String?
    @NSManaged public var c6h6IndexLevel: String?
    @NSManaged public var pm25SourceDataDate: String?
    @NSManaged public var pm25IndexLevel: String?
    @NSManaged public var no2SourceDataDate: String?
    @NSManaged public var no2IndexLevel: String?
}
