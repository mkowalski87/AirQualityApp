//
//  SensorDAO.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 27.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import CoreData

class SensorDAO {
    func saveOrUpdate(sensorObj: SensorResponse, context: NSManagedObjectContext) -> Sensor {
        let sensor = self.sensor(id: sensorObj.id, context: context) ?? Sensor(context: context)
        sensor.id = sensorObj.id
        sensor.paramCode = sensorObj.param.paramCode
        sensor.paramFormula = sensorObj.param.paramFormula
        sensor.paramName = sensorObj.param.paramName
        return sensor
    }

    func sensor(id: Int, context: NSManagedObjectContext) -> Sensor? {
        let request: NSFetchRequest<Sensor> = Sensor.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d", id)
        request.fetchLimit = 1
        if let results = try? context.fetch(request) {
            return results.first
        }
        return nil
    }

    func save(sensorValue: SensorValueObj, context: NSManagedObjectContext) -> SensorValue {
        let obj = SensorValue(context: context)
        obj.value = sensorValue.value == nil ? "" : "\(sensorValue.value!)"
        obj.date = sensorValue.date
        return obj
    }
}
