//
//  SimpleQualityIndexCell.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 20.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import UIKit

class SimpleQualityIndexCell: UITableViewCell {

    @IBOutlet weak var indexNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var indexLevelLabel: UILabel!

    static let cellIdentifier = "SimpleQualityIndexCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
