//
//  Service.swift
//  Weather
//
//  Created by Tiago Oliveira on 07/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import Foundation
import Aquino

class ForecastService {
    let provider = Provider()
    
    func getWeather(latitude: String, longitude: String, unitMetric: String = "metric", completion: @escaping (Result<ForecastModel, Error>) -> Void) -> Void {
        do {
            try provider.execute(model: ForecastModel.self, endpoint: ForecastAPI.forecastNow(latitude: latitude, longitude: longitude, unitMetric: unitMetric)) { (result) in
                switch result {
                
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
