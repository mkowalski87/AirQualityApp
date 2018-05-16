//
//  SearchStationViewController.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 09.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import UIKit
import RxSwift

class SearchStationViewController: UIViewController {

    var presenter: SearchStationPresenterProtocol?
    var searchController = UISearchController(searchResultsController: nil)
    let disposeBag: DisposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = UIRefreshControl()
        tableView.tableHeaderView = searchController.searchBar
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.delegate = self
        presenter?.viewDidLoad.on(.next(()))
        configureRx()
    }

    func configureRx() {
        guard let presenter = presenter else {
            return
        }

        presenter.stations.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: SearchStationCell.cellIdentifier, cellType: SearchStationCell.self)) { (index, station, cell) in
                cell.stationNameLabel.text = station.name
                cell.cityLabel.text = station.city
                station.favourite.asObservable().map({ !$0 }).bind(to: cell.favouriteIcon.rx.isHidden).disposed(by: cell.disposeBag)
            }.disposed(by: disposeBag)

        searchController.searchBar.rx.text
            .orEmpty
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: presenter.searchText).disposed(by: disposeBag)

        tableView.refreshControl?.rx.controlEvent(UIControlEvents.valueChanged).subscribe { (event) in
            presenter.refresh()
        }.disposed(by: disposeBag)

        presenter.isRefreshing.asObservable().bind(to: tableView.refreshControl!.rx.isRefreshing).disposed(by: disposeBag)
        tableView.rx.modelSelected(SearchStationViewModel.self).do(onNext: { model in
            self.searchController.dismiss(animated: true, completion: nil)
        }).bind(to: presenter.selectedModel).disposed(by: disposeBag)

        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }

}

extension SearchStationViewController: UISearchControllerDelegate {
    
}

extension SearchStationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .default, title: "Favourite", handler: { (action, indexPath) in
            if let station = self.presenter?.stations.value[indexPath.row] {
                self.presenter?.toggleFavourite.onNext(station)
            }
        })
        action.backgroundColor = .blue
        return [action]
    }
}
