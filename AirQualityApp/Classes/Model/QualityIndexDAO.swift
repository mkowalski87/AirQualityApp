//
//  QualityIndexDAO.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 15.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import CoreData

class QualityIndexDAO {

    func saveOrUpdate(qualityIndexResponse: GetQualityIndexResponse, context: NSManagedObjectContext) -> QualityIndex {
        let qualityIndex = get(id: qualityIndexResponse.id, context: context) ??  QualityIndex(context: context)
        qualityIndex.id = Int64(qualityIndexResponse.id)
        qualityIndex.indexLevelName = qualityIndexResponse.stIndexLevel.indexLevelName
        qualityIndex.calcDate = qualityIndexResponse.stCalcDate

        qualityIndex.so2SourceDataDate = qualityIndexResponse.so2SourceDataDate
        qualityIndex.so2IndexLevel = qualityIndexResponse.so2IndexLevel?.indexLevelName

        qualityIndex.noSourceDataDate = qualityIndexResponse.noSourceDataDate
        qualityIndex.noIndexLevel = qualityIndexResponse.noIndexLevel?.indexLevelName

        qualityIndex.coSourceDataDate = qualityIndexResponse.coSourceDataDate
        qualityIndex.coIndexLevel = qualityIndexResponse.coIndexLevel?.indexLevelName

        qualityIndex.pm10SourceDataDate = qualityIndexResponse.pm10SourceDataDate
        qualityIndex.pm10IndexLevel = qualityIndexResponse.pm10IndexLevel?.indexLevelName
        qualityIndex.pm25SourceDataDate = qualityIndexResponse.pm25SourceDataDate
        qualityIndex.pm25IndexLevel = qualityIndexResponse.pm25IndexLevel?.indexLevelName

        qualityIndex.o3SourceDataDate = qualityIndexResponse.o3SourceDataDate
        qualityIndex.o3IndexLevel = qualityIndexResponse.o3IndexLevel?.indexLevelName

        qualityIndex.c6h6IndexLevel = qualityIndexResponse.c6h6IndexLevel?.indexLevelName
        qualityIndex.c6h6SourceDataDate = qualityIndexResponse.c6h6SourceDataDate

        qualityIndex.no2SourceDataDate = qualityIndexResponse.no2SourceDataDate
        qualityIndex.no2IndexLevel = qualityIndexResponse.no2IndexLevel?.indexLevelName

        return qualityIndex
    }

    func get(id: Int, context: NSManagedObjectContext) -> QualityIndex? {
        let request = NSFetchRequest<QualityIndex>(entityName: "QualityIndex")
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

    func getLatestBy(stationId: Int, context: NSManagedObjectContext) -> QualityIndex? {
        let request = NSFetchRequest<QualityIndex>(entityName: "QualityIndex")
        request.predicate = NSPredicate(format: "station.id = %d", stationId)
        request.sortDescriptors = [NSSortDescriptor(key: "calcDate", ascending: false)]
        request.fetchLimit = 1
        if let results = try? context.fetch(request) {
            return results.first
        }
        return nil
    }
}

