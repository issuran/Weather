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
import Kingfisher

class HomeViewController: BaseViewController {
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    @IBOutlet weak var cityLabel: UIButton!
    @IBOutlet weak var todayDateLabel: UILabel!
    
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var currentSkyDescriptionLabel: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var skyDetailDescriptionLabel: UILabel!
    
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    var viewModel: HomeViewModel?
    
    enum LocaleState {
        case allowed, denied
    }
    
    var state = LocaleState.denied {
        didSet {
            if state == .allowed {
                drawScreen()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    func drawScreen() {
        DispatchQueue.main.async {
            self.startLoading()
            self.viewModel?.getWeather(latitude: "\(self.currentLocation.coordinate.latitude)",
            longitude: "\(self.currentLocation.coordinate.longitude)") { (forecast) in
                guard let forecast = forecast else { return }
                self.stopLoading()
                print(forecast)
                self.fillScreenDetails(forecast)
            }
        }
    }
    
    func fillScreenDetails(_ forecast: ForecastModel) {
        DispatchQueue.main.async {
            self.cityLabel.setTitle(forecast.name, for: .normal)
            
            let date = Date()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.string(from: date)
            
            self.todayDateLabel.text = dateFormatter.string(from: date)
            
            self.currentTemperature.text = "\(forecast.main.temp) ºC"
            self.minTemperatureLabel.text = "min: \(forecast.main.temp_min) ºC"
            self.maxTemperatureLabel.text = "max: \(forecast.main.temp_max) ºC"
            self.currentSkyDescriptionLabel.text = forecast.weather.first?.main
            let description = forecast.weather.first?.description ?? ""
            self.skyDetailDescriptionLabel.text = description.capitalizingFirstLetter()
            
            self.feelsLikeLabel.text = "\(forecast.main.feels_like) ºC Feels like"
            self.windSpeedLabel.text = "\(forecast.wind.speed) m/s Wind"
            self.humidityLabel.text = "\(forecast.main.humidity)% Humidity"
            
            let icon = forecast.weather.first?.icon ?? ""
            let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
            let url = URL(string: urlString)
            let processor = DownsamplingImageProcessor(size: self.imgWeather.bounds.size)
                |> RoundCornerImageProcessor(cornerRadius: 20)
            self.imgWeather.kf.indicatorType = .activity
            self.imgWeather.kf.setImage(
                with: url,
                placeholder: nil,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    debugPrint("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    debugPrint("Job failed: \(error.localizedDescription)")
                }
            }
        }
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
            if currentLocation != nil {
                state = .allowed
            } else {
                state = .denied
            }
            state = .allowed
//            debugPrint(currentLocation.coordinate.latitude)
//            debugPrint(currentLocation.coordinate.longitude)
//            lookUpCurrentLocation { (placemark) in
//                debugPrint(placemark?.country ?? "no country\n")
//                debugPrint(placemark?.locality ?? "no locality\n")
//                debugPrint(placemark?.administrativeArea ?? "no administrativeArea\n")
//            }
        } else {
            // Draw generic screen
            state = .denied
        }
    }
}
