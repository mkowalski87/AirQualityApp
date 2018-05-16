//
//  AppCoordinator.swift
//  AirQualityApp
//
//  Created by Michal Kowalski on 15.03.2018.
//  Copyright © 2018 Michal Kowalski. All rights reserved.
//

import UIKit

class AppCoordinator {
    var window: UIWindow
    var baseController: UIViewController!

    init(window: UIWindow) {
        self.window = window
        self.window.makeKeyAndVisible()
    }

    var searchStationViewControlller: SearchStationViewController? {
        if let mainTabBarVC = baseController as? UITabBarController, let navSearch = mainTabBarVC.childViewControllers.first as? UINavigationController , let searchVC = navSearch.viewControllers.first as? SearchStationViewController {
            return searchVC
        }
        return nil
    }

    var searchMapViewControlller: SearchMapViewController? {
        if let mainTabBarVC = baseController as? UITabBarController, let navSearch = mainTabBarVC.childViewControllers[1] as? UINavigationController , let mapVC = navSearch.viewControllers.first as? SearchMapViewController {
            return mapVC
        }
        return nil
    }

    var favouriteListViewController: FavouriteListViewController? {
        if let mainTabBarVC = baseController as? UITabBarController, let navSearch = mainTabBarVC.childViewControllers[2] as? UINavigationController , let favVC = navSearch.viewControllers.first as? FavouriteListViewController {
            return favVC
        }
        return nil
    }

    func start() {
        baseController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainTabBarController")
        window.rootViewController = baseController
        configureSearchStationVC()
        configureSearchMapVC()
        configureFavouriteListVC()
    }

    func configureSearchStationVC() {
        if let searchVC = searchStationViewControlller {
            let searchStationPresenter = SearchStationPresenter()
            searchStationPresenter.router.appCordinator = self
            searchVC.presenter = searchStationPresenter
        }
    }

    func configureSearchMapVC() {
        if let mapVC = searchMapViewControlller {
            let searchMapPresenter = SearchMapPresenter()
            searchMapPresenter.router.appCordinator = self
            mapVC.presenter = searchMapPresenter
        }
    }

    func configureFavouriteListVC() {
        if let favVC = favouriteListViewController {
            let favouriteListPresenter = FavouriteListPresenter()
            favouriteListPresenter.router?.appCordinator = self
            favVC.presenter = favouriteListPresenter
        }
    }

    func showStationDetails(stationId: Int) {
        if let stationDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StationDetailsViewController") as? StationDetailsViewController {
            let presenter = StationDetailsPresenter(stationId: stationId)
            presenter.router?.appCordinator = self
            stationDetailsViewController.presenter = presenter
            searchStationViewControlller?.navigationController?.pushViewController(stationDetailsViewController, animated: true)
        }
    }

    func showSensorDetails(stationId: Int) {
        if let sensorDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SensorDetailsViewController") as? SensorDetailsViewController {
            sensorDetailsViewController.presenter = SensorDetailsPresenter(stationId: stationId)
            searchStationViewControlller?.navigationController?.pushViewController(sensorDetailsViewController, animated: true)
        }
    }
}
