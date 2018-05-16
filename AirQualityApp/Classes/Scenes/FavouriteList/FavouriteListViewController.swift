//
//  FavouriteListViewController.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 26.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class FavouriteListViewController: UIViewController {

    var presenter: FavouriteListPresenterProtocol?

    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = UIRefreshControl()
        bindRx()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.refreshEvent.onNext(())
    }

    func bindRx() {
        guard let presenter = presenter else {
            return
        }
        presenter.stations.bind(to: tableView.rx.items(cellIdentifier: FavouriteStationCell.reuseIdentifier, cellType: FavouriteStationCell.self)) { (indexPath, model, cell) in
            cell.stationName.text = model.name
            cell.dateLabel.text = model.date
            cell.indexLabel.text = model.overallIndex
        }.disposed(by: self.disposeBag)

        tableView.refreshControl?.rx.controlEvent(UIControlEvents.valueChanged).bind(to: presenter.updateIndexes).disposed(by: disposeBag)
        presenter.isRefreshing.asObservable().bind(to: tableView.refreshControl!.rx.isRefreshing).disposed(by:disposeBag)

    }
}
