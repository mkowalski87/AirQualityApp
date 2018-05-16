//
//  MapAnnotation.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 23.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import MapKit

class MapAnnotation: NSObject, MKAnnotation {

    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let id: Int
    let qualityIndex: String?

    init(station: Station, index: String?) {
        coordinate = CLLocationCoordinate2D(latitude: station.coordLat, longitude: station.coordLon)
        title = station.stationName
        subtitle = station.city.name
        id = station.id
        qualityIndex = index
    }

    var indexImage: UIImage {
        switch qualityIndex {
        case "Umiarkowany"?:
            return #imageLiteral(resourceName: "pin-yellow")
        case "Dobry"?, "Bardzo dobry"?:
            return #imageLiteral(resourceName: "pin-green")
        default:
            return #imageLiteral(resourceName: "pin-gray")
        }
    }
}
