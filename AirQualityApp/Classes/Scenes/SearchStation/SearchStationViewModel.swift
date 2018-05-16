//
//  SearchStationViewModel.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 09.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import RxSwift

struct SearchStationViewModel {
    let id: Int
    let name: String
    let city: String
    let favourite = Variable<Bool>(false)
    
    init(station: Station) {
        id = station.id
        name = station.stationName
        city = station.city.name
        favourite.value = station.favourite
    }
}
