//
//  FavouriteListInteractor.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 26.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import RxSwift

class FavouriteListInteractor {
    let stationDAO = StationDAO()
    let qualityIndexDAO = QualityIndexDAO()

    func favouriteList() -> Observable<[FavouriteStation]> {
        let ctx = CoreDataHelper.instance.viewContext
        let observableStations = Observable.just(stationDAO.allFavourites(context: ctx))
        return observableStations.map { (stations) -> [FavouriteStation] in
            stations.map { (station) -> FavouriteStation in
                        return FavouriteStation(station: station, index: self.qualityIndexDAO.getLatestBy(stationId: station.id, context: ctx))
                    }
        }
    }

    func updateIndexes() -> [Observable<QualityIndex>] {
        let ctx = CoreDataHelper.instance.viewContext
        let favStations = stationDAO.allFavourites(context: ctx)
        return favStations.map {
            APIClient.instance.getStationsQualityIndex(stationId: $0.id)
        }
    }
}
