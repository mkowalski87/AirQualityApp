//
//  SearchStationRouter.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 09.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation

class SearchStationRouter {
    weak var appCordinator: AppCoordinator?

    func showDetails(stationId: Int) {
        appCordinator?.showStationDetails(stationId: stationId)
    }
}
