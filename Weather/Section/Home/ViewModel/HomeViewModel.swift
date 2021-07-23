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
            case .success(let model):
                self.forecastModel = model
            case .failure(_):
                self.forecastModel = nil
            }
            
            completion(self.forecastModel)
        }
    }
    
    func formattedDate() -> String {

        let date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.string(from: date)
        
        return dateFormatter.string(from: date)
    }
    
    func iconUrl(_ icon: String) -> URL? {
        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        
        return URL(string: urlString)
    }
}
