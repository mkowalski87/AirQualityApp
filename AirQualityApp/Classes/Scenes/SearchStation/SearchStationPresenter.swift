//
//  SearchStationPresenter.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 09.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchStationPresenterProtocol: class {
    var stations: Variable<[SearchStationViewModel]> { get }
    var searchText: PublishSubject<String> { get }
    var isRefreshing: Variable<Bool> { get }
    var selectedModel: Variable<SearchStationViewModel?> { get }
    var toggleFavourite: PublishSubject<SearchStationViewModel> { get }
    var viewDidLoad: PublishSubject<Void> { get }
    
    func refresh()
}

class SearchStationPresenter: SearchStationPresenterProtocol {

    var selectedModel: Variable<SearchStationViewModel?> = Variable<SearchStationViewModel?>(nil)
    var isRefreshing: Variable<Bool> = Variable<Bool>(false)
    let stations: Variable<[SearchStationViewModel]> = Variable<[SearchStationViewModel]>([])
    let searchText: PublishSubject<String> = PublishSubject<String>()
    var interactor: SearchStationInteractorProtocol? = SearchStationInteractor()
    var router = SearchStationRouter()
    let disposeBag = DisposeBag()
    let toggleFavourite: PublishSubject<SearchStationViewModel> = PublishSubject<SearchStationViewModel>()
    let viewDidLoad: PublishSubject<Void> = PublishSubject<Void>()
    
    init() {
        configureRx()
    }

    func configureRx() {
        searchText.bind { (query) in
                                self.interactor?.searchStation(query: query)
                                .map({ (stations) -> [SearchStationViewModel] in
                                    return stations.map { SearchStationViewModel.init(station: $0) }
                                    })
                                .bind(to: self.stations)
                                .disposed(by: self.disposeBag)

                            }.disposed(by: disposeBag)

        ///show station details
        selectedModel.asObservable().subscribe(onNext: { (model) in
            if let model = model {
                self.router.showDetails(stationId: model.id)
            }
        }).disposed(by: disposeBag)

        toggleFavourite.subscribe(onNext: { (model) in
            model.favourite.value = !model.favourite.value
            self.switchFavourite(stationId: model.id)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        viewDidLoad.subscribe(onNext: { (model) in
                self.refresh()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    func refresh() {
        guard let interactor = interactor else {
            return
        }

        let stationsVM = interactor.refreshStations().map({ (stations) -> [SearchStationViewModel] in
            return stations.map { SearchStationViewModel.init(station: $0)  }
        }).asDriver(onErrorJustReturn: [])

        stationsVM.map { (_) -> Bool in
            return false
        }.drive(isRefreshing).disposed(by: disposeBag)

        stationsVM.drive(self.stations).disposed(by: disposeBag)
    }

    func switchFavourite(stationId: Int) {
        _ = self.interactor?.toggleFavourite(stationId: stationId)
    }
}
