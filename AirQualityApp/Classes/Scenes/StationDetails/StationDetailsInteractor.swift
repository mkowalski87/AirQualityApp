//
//  StationDetailsInteractor.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 15.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import RxSwift

class StationDetailsInteractor {
    let stationDAO = StationDAO()
    let qualityIndexDAO = QualityIndexDAO()

    func station(with id: Int) -> Observable<StationDetailsViewModel.StationInfo> {
        return Observable.create({ (observer) -> Disposable in
            if let station = self.stationDAO.get(id: id, context: CoreDataHelper.instance.viewContext) {
                observer.onNext(StationDetailsViewModel.StationInfo(id: station.id, stationName: station.stationName, street: station.street, city: station.city.name))
            }
            observer.onCompleted()
            return Disposables.create()
        })
    }

    func getQualityIndex(id: Int) -> Observable<StationDetailsViewModel.QualityIndexVM> {
        return Observable.create({ (observer) -> Disposable in
            if let qualityIndex = self.qualityIndexDAO.getLatestBy(stationId: id, context: CoreDataHelper.instance.viewContext) {
                observer.onNext(StationDetailsViewModel.QualityIndexVM(obj: qualityIndex))
            }
            return Disposables.create()
        })
    }

    func fetchQualityIndex(stationId: Int) -> Observable<StationDetailsViewModel.QualityIndexVM> {
        return APIClient.instance.getStationsQualityIndex(stationId: stationId).map({ (qualityIndex) -> StationDetailsViewModel.QualityIndexVM in
            StationDetailsViewModel.QualityIndexVM(obj: qualityIndex)
        })
    }
}
