//
//  Service.swift
//  Weather
//
//  Created by Tiago Oliveira on 07/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import Foundation
import Aquino

class ForecastService: Provider {
    let provider = Provider()
    
    func getWeather(latitude: String, longitude: String, unitMetric: String = "metric", completion: @escaping (Result<ForecastModel>) -> Void) -> Void {
        do {
            try provider.execute(endpoint: ForecastAPI.forecastNow(latitude: latitude, longitude: longitude, unitMetric: unitMetric)) { (result) in
                switch result {
                case .success(let data, let response):
                    let decoder = JSONDecoder()
                    let model = try! decoder.decode(ForecastModel.self, from: data)
                    completion(.success(model, response))
                case .failure(let error):
                    completion(.failure(error))
                case .empty:
                    completion(.failure(ServiceError.encodingFailed))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
