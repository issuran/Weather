//
//  WeatherModel.swift
//  Weather
//
//  Created by Tiago Oliveira on 10/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import UIKit

struct ForecastModel: Codable {
    let weather: [Weather]
    let main: Temperature
    let wind: Wind
    let name: String
}

struct Weather: Codable {
    let main: String
    let description: String
    let icon: String
}

struct Temperature: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
}

struct Wind: Codable {
    let speed: Double
}
