//
//  GetSensorsResponse.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 27.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation

struct SensorResponse: Codable {
    let id: Int
    let stationId: Int
    let param: SensorParam
}

struct SensorParam: Codable {
    let paramName: String
    let paramFormula: String
    let paramCode: String
}

typealias GetSensorsResponse = [SensorResponse]
