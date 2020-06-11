//
//  HomeViewModel.swift
//  Weather
//
//  Created by Tiago Oliveira on 06/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    let service = ForecastService()
    var forecastModel: ForecastModel?
    
    func getWeather(latitude: String, longitude: String, unit: String = "metric", completion: @escaping (ForecastModel?) -> Void) -> Void {
        service.getWeather(latitude: latitude, longitude: longitude) { (result) in
            switch result {
            case .success(let model, _):
                self.forecastModel = model
            case .failure(_), .empty:
                self.forecastModel = nil
            }
            
            completion(self.forecastModel)
        }
    }
}
