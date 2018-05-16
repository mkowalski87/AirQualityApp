//
//  FavouriteStation.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 26.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation

class FavouriteStation {
    let id: Int
    let name: String
    let overallIndex: String?
    let date: String?

    init(station: Station, index: QualityIndex?) {
        id = station.id
        name = station.stationName
        overallIndex = index?.indexLevelName
        date = index?.calcDate
    }
    
}
