//
//  WeatherData.swift
//  OpenWeather
//
//  Created by Koushal, KumarAjitesh on 2019/06/02.
//  Copyright © 2019 Koushal, KumarAjitesh. All rights reserved.
//

import Foundation
import UIKit

struct WeatherData {
    var weatherInfo: WeatherInfo?
    var iconImage: UIImage?
}

struct WeatherInfo: Codable {
    let coord: Coord
    let main: Temperature
    let weather: [Weather]
    let wind: Wind
    let clouds: Clouds
    let dt: Double
    let sys: Sys
    var name: String = "Error: invalid jsonDictionary! Verify your appID is correct"
}

struct Coord: Codable {
    let lat: Double
    let lon: Double
}

struct Wind: Codable {
    let speed: Double
}

struct Clouds: Codable {
    let all: Double
}

struct Weather: Codable {
    let icon: String
    let description: String
}

struct Sys: Codable {
    let sunrise: Double
    let sunset: Double
}

struct Temperature: Codable {
    let temp: Double
    let pressure: Double
    let humidity: Double
    let temp_min: Double
    let temp_max: Double
}
