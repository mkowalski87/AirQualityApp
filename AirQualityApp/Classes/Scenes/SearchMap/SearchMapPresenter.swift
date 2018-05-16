//
//  SearchMapPresenter.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 23.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchMapPresenterProtocol: class {
    var annotations: Observable<[MapAnnotation]> { get }
    var router: SearchMapRouter { get set }
    func refresh()
}

class SearchMapPresenter: SearchMapPresenterProtocol {
    private let _annotations = Variable<[MapAnnotation]>([])

    var annotations: Observable<[MapAnnotation]> {
        return _annotations.asObservable()
    }

    var router: SearchMapRouter = SearchMapRouter()
    var interactor = SearchMapInteractor()
    let disposeBag = DisposeBag()

    init() {
        bindRx()
    }

    func bindRx() {
        getAnnotations()
    }

    private func getAnnotations() {
        interactor.allStations().map { [unowned self] (stations) -> [MapAnnotation] in
            stations.map {
                MapAnnotation.init(station: $0, index: self.interactor.latestIndex(station: $0))
            }
            }.bind { [unowned self] (annotations) in
                self._annotations.value = annotations
            }.disposed(by: disposeBag)
    }

    func refresh() {
        getAnnotations()
    }
}
