//
//  StationDetailsViewModel.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 15.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import RxSwift

struct StationDetailsViewModel {

    struct StationInfo {
        let id: Int
        let stationName: String
        let street: String?
        let city: String
    }

    struct QualityIndexVM {
        let levelName: String
        let date: String

        let so2IndexLevel: String?
        let so2Date: String?
        let noDate: String?
        let noIndexLevel: String?
        let no2Date: String?
        let no2IndexLevel: String?
        let coDate: String?
        let coIndexLevel: String?
        let pm10Date: String?
        let pm10IndexLevel: String?
        let pm25Date: String?
        let pm25IndexLevel: String?
        let o3Date: String?
        let o3IndexLevel: String?
        let c6h6Date: String?
        let c6h6IndexLevel: String?

        init(obj: QualityIndex) {
            levelName = obj.indexLevelName
            date = obj.calcDate
            so2IndexLevel = obj.so2IndexLevel
            so2Date = obj.so2SourceDataDate
            noDate = obj.noSourceDataDate
            noIndexLevel = obj.noIndexLevel
            no2Date = obj.no2SourceDataDate
            no2IndexLevel = obj.no2IndexLevel
            coDate = obj.coSourceDataDate
            coIndexLevel = obj.coIndexLevel
            pm10Date = obj.pm10SourceDataDate
            pm10IndexLevel = obj.pm10IndexLevel
            o3Date = obj.o3SourceDataDate
            o3IndexLevel = obj.o3IndexLevel
            pm25Date = obj.pm25SourceDataDate
            pm25IndexLevel = obj.pm25IndexLevel
            c6h6Date = obj.c6h6SourceDataDate
            c6h6IndexLevel = obj.c6h6IndexLevel
        }

        var indexes: Observable<[SimpleIndex]> {
            return Observable.just([("Dwutlenek Siarki",so2Date, so2IndexLevel),
                                     ("Tlenek Azotu",noDate, noIndexLevel),
                                     ("Dwutlenek Azotu",no2Date, no2IndexLevel),
                                     ("Tlenek Węgla",coDate, coIndexLevel),
                                     ("Pyły zawieszone PM10",pm10Date, pm10IndexLevel),
                                     ("Pyły zawieszone PM25",pm25Date, pm25IndexLevel),
                                     ("Benzen",c6h6Date, c6h6IndexLevel),
                                     ("Ozon",o3Date, o3IndexLevel)].flatMap { (name, date, level) -> SimpleIndex? in
                                        if let date = date, let level = level {
                                            return SimpleIndex(name: name, date: date, level: level)
                                        }
                                        return nil
            })
        }
    }

    struct SimpleIndex {
        let name: String
        let date: String
        let level: String
    }
}
