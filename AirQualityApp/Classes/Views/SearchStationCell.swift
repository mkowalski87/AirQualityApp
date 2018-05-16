//
//  SearchStationCell.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 09.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import UIKit
import RxSwift

class SearchStationCell: UITableViewCell {

    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var favouriteIcon: UIImageView!

    var disposeBag = DisposeBag()

    static let cellIdentifier = "SearchStationCell"

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

}
