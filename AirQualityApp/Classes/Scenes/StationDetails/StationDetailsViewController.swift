//
//  StationDetailsViewController.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 15.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa

class StationDetailsViewController: UIViewController {

    var presenter: StationDetailsPresenterProtocol?
    let disposeBag = DisposeBag()

    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var levelNameLabel: UILabel!
    @IBOutlet weak var showDetailsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = UIRefreshControl()
        bindRx()
        self.presenter?.reloadView()
    }

    func bindRx() {
        guard let presenter = presenter else {
            return
        }
        let stationInfoObservable = presenter.stationInfo
        stationInfoObservable.asObservable().map({ $0?.stationName }).bind(to: stationNameLabel.rx.text).disposed(by: disposeBag)
        stationInfoObservable.asObservable().map({ $0?.street }).bind(to: streetLabel.rx.text).disposed(by: disposeBag)

        let qualityIndexObservable = presenter.qualityIndex
        qualityIndexObservable.asObservable().map({ $0.date }).bind(to: dateLabel.rx.text).disposed(by: disposeBag)
        qualityIndexObservable.asObservable().map({ $0.levelName }).bind(to: levelNameLabel.rx.text).disposed(by: disposeBag)

        tableView.refreshControl?.rx.controlEvent(UIControlEvents.valueChanged).subscribe(onNext: {
            self.presenter?.refresh()
        }).disposed(by: disposeBag)

        qualityIndexObservable.asObservable().flatMap { (index) -> Observable<[StationDetailsViewModel.SimpleIndex]> in
            return index.indexes
            }.bind(to: tableView.rx.items(cellIdentifier: SimpleQualityIndexCell.cellIdentifier, cellType: SimpleQualityIndexCell.self)) { (index, item, cell) in
                cell.indexNameLabel.text = item.name
                cell.dateLabel.text = item.date
                cell.indexLevelLabel.text = item.level
            }.disposed(by: disposeBag)

        presenter.isRefreshing.asObservable().bind(to: tableView.refreshControl!.rx.isRefreshing).disposed(by: disposeBag)
        showDetailsButton.rx.tap.bind(to: presenter.showDetails).disposed(by: disposeBag)
    }
}
