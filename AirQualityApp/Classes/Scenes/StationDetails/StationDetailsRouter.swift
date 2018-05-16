//
//  StationDetailsRouter.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 15.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation

class StationDetailsRouter {
    weak var appCordinator: AppCoordinator?

    func showSensorDetails(stationId: Int) {
        appCordinator?.showSensorDetails(stationId: stationId)
    }
}
