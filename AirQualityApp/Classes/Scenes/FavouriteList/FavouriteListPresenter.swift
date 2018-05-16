//
//  FavouriteListPresenter.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 26.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import RxSwift

protocol FavouriteListPresenterProtocol {
    var router: FavouriteListRouter? { get set }

    var refreshEvent: PublishSubject<Void> { get }
    var updateIndexes: PublishSubject<Void> { get }
    var stations: Observable<[FavouriteStation]> { get}
    var isRefreshing: Variable<Bool> { get }
}

class FavouriteListPresenter: FavouriteListPresenterProtocol {
    var router: FavouriteListRouter?
    var interactor = FavouriteListInteractor()

    let refreshEvent: PublishSubject<Void> = PublishSubject<Void>()
    let updateIndexes: PublishSubject<Void> = PublishSubject<Void>()
    let isRefreshing: Variable<Bool> = Variable<Bool>(false)

    let disposeBag = DisposeBag()
    private let _stations: Variable<[FavouriteStation]> = Variable<[FavouriteStation]>([])

    var stations: Observable<[FavouriteStation]> {
        return _stations.asObservable()
    }

    init() {
        bindRx()
    }

    func bindRx() {
        refreshEvent.bind(onNext: { [unowned self] (_) in
            self.reloadFavList()
        }).disposed(by: disposeBag)


        updateIndexes.bind { (_) in
            self.isRefreshing.value = true
            self.startUpdateIndexes()
        }.disposed(by: disposeBag)
    }

    func startUpdateIndexes() {
        let array = interactor.updateIndexes()

            Observable.from(array).flatMap {
                    $0
                }.map { (qualityIndex) -> FavouriteStation in
                    FavouriteStation(station: qualityIndex.station, index: qualityIndex)
                }
                .toArray()
                .asDriver(onErrorJustReturn: []).drive(onNext: { (stations) in
                    if stations.isEmpty {
                        self.reloadFavList()
                    } else {
                        self._stations.value = stations
                    }
                    self.isRefreshing.value = false

                }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    func reloadFavList() {
        interactor.favouriteList().bind(onNext: {
            self._stations.value = $0
        }).disposed(by: self.disposeBag)
    }
}
