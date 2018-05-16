//
//  SensorDetailsViewController.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 27.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class SensorDetailsViewController: UIViewController {

    var presenter: SensorDetailsPresenter?
    var dataSource: RxTableViewSectionedReloadDataSource<SensorData>?
    let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindRx()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.reloadView.onNext(())
    }

    func bindRx() {
        dataSource = RxTableViewSectionedReloadDataSource<SensorData>(configureCell: { (dataSource, tableView, indexPath, dataItem) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "sensorDataItemCell", for: indexPath)
            cell.textLabel?.text = dataItem.date
            cell.detailTextLabel?.text = dataItem.value
            return cell
        })

        dataSource?.titleForHeaderInSection = { (ds, index) in
            return ds.sectionModels[index].paramName
        }

        presenter?.sensors.asObservable().bind(to: tableView.rx.items(dataSource: dataSource!)).disposed(by: disposeBag)
    }
}
