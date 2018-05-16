//
//  SearchMapInteractor.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 23.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import RxSwift

class SearchMapInteractor {

    var stationDAO = StationDAO()
    let qualityIndexDAO = QualityIndexDAO()

    func allStations() -> Observable<[Station]> {
        return Observable.just(stationDAO.all(context: CoreDataHelper.instance.viewContext))
    }

    func latestIndex(station: Station) -> String? {
        guard let context = station.managedObjectContext else {
            return nil
        }
        return qualityIndexDAO.getLatestBy(stationId: station.id, context: context)?.indexLevelName
    }
}
