//
//  API.swift
//  Weather
//
//  Created by Tiago Oliveira on 07/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import Foundation
import Aquino
import Keys

enum ForecastAPI {
    case forecastNow(latitude: String, longitude: String, unitMetric: String)
}

extension ForecastAPI: ServiceProtocol {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.openweathermap.org"
    }
    
    var path: String {
        return "/data/2.5/weather"
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var task: HttpTask {
        switch self {
        case .forecastNow(let latitude, let longitude, let unitMetric):
            let params: Parameters = [
                "lat": "\(latitude)",
                "lon": "\(longitude)",
                "appid": "\(WeatherKeys().apiKey)",
                "units": "\(unitMetric)"
            ]
            return .requestUrlParameters(urlParameters: params)
        }
    }
}
