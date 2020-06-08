//
//  AppCoordinator.swift
//  Weather
//
//  Created by Tiago Oliveira on 06/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var window: UIWindow
    var navigationController: UINavigationController
    
    // Login
//    var loginCoordinator: LoginCoordinator!
    
    required init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        let vc = SecurityViewController.instantiate(.Security)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func homeWeather() {
        let vc = HomeViewController.instantiate(.Home)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func currentWeather() {
        let vc = CurrentWeatherViewController.instantiate(.CurrentWeather)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
