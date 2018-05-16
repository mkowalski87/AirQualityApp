//
//  GetSensorValuesResponse.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 28.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation

struct GetSensorValuesResponse: Codable {
    let key: String
    let values: [SensorValueObj]
}

struct SensorValueObj: Codable {
    let date: String
    let value: Double?
}
