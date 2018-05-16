//
//  SearchStationInteractor.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 09.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchStationInteractorProtocol: class {
    func searchStation(query: String) -> Observable<[Station]>
    func refreshStations() -> Observable<[Station]>
    func toggleFavourite(stationId: Int)
}

class SearchStationInteractor: SearchStationInteractorProtocol {

    var stationDAO = StationDAO()
    var apiClient = APIClient()

    func searchStation(query: String) -> Observable<[Station]> {
        guard !query.isEmpty else {
            return Observable.just(stationDAO.all(context: CoreDataHelper.instance.viewContext))
        }
        return Observable.just(stationDAO.search(with: query, context: CoreDataHelper.instance.viewContext))
    }

    func refreshStations() -> Observable<[Station]> {
        return apiClient.getStations()
    }

    func toggleFavourite(stationId: Int) {
        _ = stationDAO.toggleFavourite(stationId: stationId, context: CoreDataHelper.instance.viewContext)
        CoreDataHelper.instance.save(context: CoreDataHelper.instance.viewContext)
    }
}
