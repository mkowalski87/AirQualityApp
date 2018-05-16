//
//  StationDetailsPresenter.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 15.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol StationDetailsPresenterProtocol {
    var stationInfo: Variable<StationDetailsViewModel.StationInfo?> { get }
    var qualityIndex: PublishSubject<StationDetailsViewModel.QualityIndexVM> { get }
    var isRefreshing: Variable<Bool> { get }
    var showDetails: PublishSubject<Void> { get }
    var router: StationDetailsRouter? { get set }

    func reloadView()
    func refresh()
}

class StationDetailsPresenter: StationDetailsPresenterProtocol {
    var qualityIndex: PublishSubject<StationDetailsViewModel.QualityIndexVM> = PublishSubject<StationDetailsViewModel.QualityIndexVM>()

    var stationInfo: Variable<StationDetailsViewModel.StationInfo?> = Variable<StationDetailsViewModel.StationInfo?>(nil)
    let isRefreshing: Variable<Bool> = Variable(false)
    let showDetails: PublishSubject<Void> = PublishSubject<Void>()
    var router: StationDetailsRouter? = StationDetailsRouter()

    var interactor = StationDetailsInteractor()
    let disposeBag = DisposeBag()
    let stationId: Int

    init(stationId: Int) {
        self.stationId = stationId
        configureRx()
    }

    func configureRx() {
        showDetails.bind (onNext: { [unowned self] (_) in
            self.router?.showSensorDetails(stationId: self.stationId)
        }).disposed(by: disposeBag)
    }

    func reloadView() {
        interactor.station(with: stationId).bind(to: stationInfo).disposed(by: disposeBag)
        interactor.getQualityIndex(id: stationId).bind(to: qualityIndex).disposed(by: disposeBag)
    }

    func refresh() {

        let fetchIndexObservable = interactor.fetchQualityIndex(stationId: stationId).debug().observeOn(MainScheduler.instance)

        fetchIndexObservable.map { qualityIndex -> Bool in
            return false
        }.bind(to: isRefreshing).disposed(by: disposeBag)

        fetchIndexObservable.bind(to: qualityIndex).disposed(by: disposeBag)
    }
}
