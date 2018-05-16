//
//  GetQualityIndexResponse.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 15.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation

struct GetQualityIndexResponse: Codable {

    struct QualityIndexLevel: Codable {
        let id: Int
        let indexLevelName: String
    }

    let id: Int
    let stCalcDate: String
    let stIndexLevel: QualityIndexLevel

    let so2IndexLevel: QualityIndexLevel?
    let so2SourceDataDate: String?

    let noSourceDataDate: String?
    let noIndexLevel: QualityIndexLevel?

    let no2SourceDataDate: String?
    let no2IndexLevel: QualityIndexLevel?

    let coSourceDataDate: String?
    let coIndexLevel: QualityIndexLevel?

    let pm10IndexLevel: QualityIndexLevel?
    let pm10SourceDataDate: String?

    let o3IndexLevel: QualityIndexLevel?
    let o3SourceDataDate: String?

    let pm25IndexLevel: QualityIndexLevel?
    let pm25SourceDataDate: String?

    let c6h6IndexLevel: QualityIndexLevel?
    let c6h6SourceDataDate: String?

}
