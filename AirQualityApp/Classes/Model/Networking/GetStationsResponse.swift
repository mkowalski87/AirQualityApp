//
//  GetStationsResponse.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 13.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation

struct StationCodable: Codable {
    let id: Int
    let stationName: String
    let gegrLat: String
    let gegrLon: String
    let city: CityCodable
    let addressStreet: String?
}

struct CityCodable: Codable {
    let id: Int32
    let name: String
}

typealias GetStationsResponse = [StationCodable]
