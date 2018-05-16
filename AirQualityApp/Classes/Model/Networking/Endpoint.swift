//
//  Endpoint.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 13.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation

protocol Endpoint {
    var method: String { get }
    var path: String { get }
}

enum APIEndpoint: Endpoint {

    case getStations
    case getQualityIndex(Int)
    case getSensors(Int)
    case getSensorValues(Int)

    var method: String {
        switch self {
        case .getStations, .getQualityIndex(_), .getSensors(_), .getSensorValues(_):
            return "GET"
        }
    }

    var path: String {
        switch self {
        case .getStations:
            return "station/findAll"
        case .getQualityIndex(let index):
            return "aqindex/getIndex/\(index)"
        case .getSensors(let stationId):
            return "station/sensors/\(stationId)"
        case .getSensorValues(let sensorId):
            return "data/getData/\(sensorId)"
        }
    }
}
