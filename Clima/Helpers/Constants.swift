//
//  Constants.swift
//  Clima
//
//  Created by Danijela Vrzan on 2020-01-28.
//  Copyright © 2020 Danijela Vrzan. All rights reserved.
//

import Foundation

struct K {
    static let weatherURL = "https://api.darksky.net/forecast/\(valueForAPIKey(named: "API_KEY"))" //lat,long
    static let metricUnits = "si"
    static let imperialUnits = "us"
    static let degree = "°"
    static let showSearchViewSegue = "weather-to-search-view"
    static let showWeatherViewSegue = "search-to-weather-view"
    static let tableViewCellIdentifier = "locationCell"
    
    struct Error {
        static let title = "Loading error"
        static let action = "OK"
    }
    
    struct Condition {
        static let thunderstorm = "thunderstorm"
        static let rain = "rain"
        static let hail = "hail"
        static let sleet = "sleet"
        static let snow = "snow"
        static let fog = "fog"
        static let tornado = "tornado"
        static let clearDay = "clear-day"
        static let clearNight = "clear-night"
        static let partlyCloudyDay = "partly-cloudy-day"
        static let partlyCloudyNight = "partly-cloudy-night"
        static let cloudy = "cloudy"
        static let wind = "wind"
        static let `default` = "thermometer"
    }
    
}
