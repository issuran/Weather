//
//  HomeViewController.swift
//  Weather
//
//  Created by Tiago Oliveira on 06/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import UIKit
import Keys
import CoreLocation

class HomeViewController: BaseViewController {
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var viewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    @IBAction func goNext(_ sender: Any) {
        let keys = WeatherKeys()
        debugPrint(keys.apiKey)
        drawScreen()
//        coordinator?.currentWeather()
    }
    
    func drawScreen() {
        let model = viewModel?.getWeather(latitude: "\(currentLocation.coordinate.latitude)",
                                          longitude: "\(currentLocation.coordinate.longitude)")
    }
}

extension HomeViewController {
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?) -> Void) {
        /// Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
                
            /// Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                        completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                 /// An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            /// No location was available.
            completionHandler(nil)
        }
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLocation = locationManager.location
            debugPrint(currentLocation.coordinate.latitude)
            debugPrint(currentLocation.coordinate.longitude)
            lookUpCurrentLocation { (placemark) in
                debugPrint(placemark?.country ?? "no country\n")
                debugPrint(placemark?.locality ?? "no locality\n")
                debugPrint(placemark?.administrativeArea ?? "no administrativeArea\n")
            }
        }
    }
}
