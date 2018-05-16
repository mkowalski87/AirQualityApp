//
//  SearchMapViewController.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 23.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import UIKit
import MapKit
import RxSwift
import RxMKMapView

class SearchMapViewController: UIViewController {

    var presenter: SearchMapPresenterProtocol?
    
    @IBOutlet weak var mapView: MKMapView!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        bindRx()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.refresh()
    }

    func bindRx() {
        mapView.rx.annotations(presenter!.annotations)({ (annotation) in
            annotation
        }).disposed(by: disposeBag)
    }
}

extension SearchMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MapAnnotation else {
            return nil
        }
        let  annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
        annotationView.image = annotation.indexImage
        return annotationView
    }
}
