//
//  SensorDetailsPresenter.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 27.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import RxSwift

protocol SensorDetailsPresenterProtocol: class {
    var reloadView: PublishSubject<Void> { get }
    var sensors: Variable<[SensorData]> { get }
}

class SensorDetailsPresenter: SensorDetailsPresenterProtocol {

    //input
    let reloadView: PublishSubject<Void> = PublishSubject<Void>()

    //output
    let sensors: Variable<[SensorData]> = Variable<[SensorData]>([])

    var interactor = SensorDetailsInteractor()
    let disposeBag = DisposeBag()
    let stationId: Int

    init(stationId: Int) {
        self.stationId = stationId
        bindRx()
    }

    func bindRx() {

        reloadView.flatMap {
            self.interactor.sensorData(station: self.stationId).asDriver(onErrorJustReturn: [])
        }.bind(to: sensors).disposed(by: disposeBag)
    }
}
