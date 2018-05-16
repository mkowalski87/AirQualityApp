//
//  FavouriteStationCell.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 26.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import UIKit

class FavouriteStationCell: UITableViewCell {

    static let reuseIdentifier = "FavouriteStationCell"

    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

}
