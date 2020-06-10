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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    @IBAction func goNext(_ sender: Any) {
        let keys = WeatherKeys()
        debugPrint(keys.apiKey)
        coordinator?.currentWeather()
        
//        /// Testando framework
//        let service = SignScrapService()
//        service.getSignToday(sign: "Libra") { (result) in
//            switch result {
//            case .success(_, _):
//                print("Sucesso")
//            case .failure(_):
//                print("Failure")
//            case .empty:
//                print("Empty")
//            }
//        }
//        /// Fim do teste
    }
    
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?) -> Void) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
                
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                        completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                 // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLocation = locationManager.location
            lookUpCurrentLocation { (placemark) in
                debugPrint(placemark?.country ?? "no country\n")
                debugPrint(placemark?.locality ?? "no locality\n")
                debugPrint(placemark?.administrativeArea ?? "no administrativeArea\n")
            }
        }
    }
}
