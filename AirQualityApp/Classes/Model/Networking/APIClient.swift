//
//  APIClient.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 13.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import Foundation
import RxSwift

class APIClient {
    
    static let instance = APIClient()

    var networkClient = NetworkClient(baseURL: URL(string: "http://api.gios.gov.pl/pjp-api/rest")!)
    var stationDAO: StationDAO = StationDAO()
    var sensorDAO: SensorDAO = SensorDAO()
    var cityDAO: CityDAO = CityDAO()
    var qualityIndexDAO = QualityIndexDAO()

    let disposeBag = DisposeBag()

    func getStations() -> Observable<[Station]> {
        return Observable<[Station]>.create({ (observer) -> Disposable in
            _ = self.networkClient.request(apiRequest: APIRequest(endpoint: APIEndpoint.getStations), response: GetStationsResponse.self)
                .subscribe(onSuccess: { (response) in
                        let context = CoreDataHelper.instance.privateContext
                        print("request is made")
                        print("isMainThread \(Thread.current.isMainThread)")
                        let stations = response.map { (stationObj) -> Station in
                            let station = self.stationDAO.saveOrUpdate(stationObj: stationObj, context:  context)
                            station.city = self.cityDAO.saveOrUpdate(cityObj: stationObj.city, context: context)
                            return station
                        }

                        CoreDataHelper.instance.save(context: context)
                        observer.onNext(stations)
                    }, onError: { (error) in
                        observer.onError(error)
                        print("\(error)")
                    })
            return Disposables.create()
        })
    }

    func getStationsQualityIndex(stationId: Int) -> Observable<QualityIndex> {
        return Observable<QualityIndex>.create({ (observer) -> Disposable in

            _ = self.networkClient.request(apiRequest: APIRequest(endpoint: APIEndpoint.getQualityIndex(stationId)), response: GetQualityIndexResponse.self)
                .subscribe(onSuccess: { (response) in

                    let context = CoreDataHelper.instance.privateContext
                    print("request is made")
                    print("isMainThread \(Thread.current.isMainThread)")
                    let qualityIndex = self.qualityIndexDAO.saveOrUpdate(qualityIndexResponse: response, context: context)

                    if let station = self.stationDAO.get(id: stationId, context: context) {
                        station.addToQualityIndexes(qualityIndex)
                    }

                    CoreDataHelper.instance.save(context: context)
                    observer.onNext(qualityIndex)
                    observer.onCompleted()
                }, onError: { (error) in
                    observer.onError(error)
                    print("\(error)")
                })
            return Disposables.create()

        })
    }

    func getStationSensors(stationId: Int) -> Observable<[Sensor]> {
        return Observable<[Sensor]>.create({ (observer) -> Disposable in

            _ = self.networkClient.request(apiRequest: APIRequest(endpoint: APIEndpoint.getSensors(stationId)), response: GetSensorsResponse.self)
                .subscribe(onSuccess: { (response) in

                    let context = CoreDataHelper.instance.privateContext
                    print("get station sensor \(stationId)")
                    let sensors = response.map {
                        self.sensorDAO.saveOrUpdate(sensorObj: $0, context: context)
                    }

                    if let station = self.stationDAO.get(id: stationId, context: context) {
                        sensors.forEach {
                            station.addToSensors($0)
                        }
                    }

                    CoreDataHelper.instance.save(context: context)
                    observer.onNext(sensors)
                    observer.onCompleted()
                }, onError: { (error) in
                    observer.onError(error)
                    print("\(error)")
                })
            return Disposables.create()

        })
    }

    func getSensorValues(sensorId: Int) -> Observable<[SensorValue]> {
        return Observable<[SensorValue]>.create({ (observer) -> Disposable in

            _ = self.networkClient.request(apiRequest: APIRequest(endpoint: APIEndpoint.getSensorValues(sensorId)), response: GetSensorValuesResponse.self)
                .subscribe(onSuccess: { (response) in

                    let context = CoreDataHelper.instance.privateContext
                    print("get values for sensor \(sensorId)")
                    let sensorValues = response.values.map {
                                            self.sensorDAO.save(sensorValue: $0, context: context)
                                        }
                    if let sensor = self.sensorDAO.sensor(id: sensorId, context: context) {
                        sensorValues.forEach {
                            $0.sensor = sensor
                        }
                    }
                    CoreDataHelper.instance.save(context: context)
                    observer.onNext(sensorValues)
                    observer.onCompleted()
                }, onError: { (error) in
                    observer.onError(error)
                    print("\(error)")
                })
            return Disposables.create()

        })
    }
}
