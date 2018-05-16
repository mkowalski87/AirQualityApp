//
//  SensorDetailsViewModel.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 27.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import RxDataSources

struct SensorData {

    struct SensorDataItem {
        let date: String
        let value: String
    }

    let paramName: String
    let paramCode: String
    var items: [SensorDataItem]

    init(paramName: String, paramCode: String, items: [SensorDataItem]) {
        self.paramName = paramName
        self.paramCode = paramCode
        self.items = items
    }
}

extension SensorData: SectionModelType {
    typealias Item = SensorDataItem

    init(original: SensorData, items: [Item]) {
        self = original
        self.items = items
    }
}
