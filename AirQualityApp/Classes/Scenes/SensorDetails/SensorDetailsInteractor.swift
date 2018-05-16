//
//  SensorDetailsInteractor.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 27.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import RxSwift

class SensorDetailsInteractor {
    let apiClient = APIClient()

    func sensorData(station: Int) -> Observable<[SensorData]> {
        let sensors = apiClient.getStationSensors(stationId: station).flatMap { Observable.from($0) }.share()
        let sensorsData = sensors.map {(sensor) -> Observable<SensorData> in
            let paramName = sensor.paramName
            let paramCode = sensor.paramCode
            return self.apiClient.getSensorValues(sensorId: sensor.id).map { (sensorValue) -> SensorData in

                let items = sensorValue.map {
                    SensorData.SensorDataItem(date: $0.date, value: "\($0.value)")
                }

                let sensorData = SensorData(paramName: paramName, paramCode: paramCode, items: items)
                return sensorData
            }
        }
        return sensorsData.flatMap{ $0 }.toArray()
    }

}
