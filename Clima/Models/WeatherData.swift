//
//  WeatherData.swift
//  Clima
//
//  Created by Danijela Vrzan on 2020-01-21.
//  Copyright © 2020 Danijela Vrzan. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let currently: Currently
    let daily: Daily
}

struct Currently: Codable {
    let summary: String
    let icon: String
    let temperature: Double
    let apparentTemperature: Double
    let windSpeed: Double
}

struct Daily: Codable {
    let data: [Data]
    
    struct Data: Codable {
        let sunriseTime: Double
        let sunsetTime: Double
        let temperatureMax: Double
        let temperatureMin: Double
    }
}

