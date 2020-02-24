//
//  WeatherModel.swift
//  Clima
//
//  Created by Danijela Vrzan on 2020-01-21.
//  Copyright © 2020 Danijela Vrzan. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let latitude: Double
    let longitude: Double
    let currentSummary: String
    let currentIcon: String
    let currentTemperature: Double
    let feelsLike: Double
    let windSpeed: Double
    let dailySunriseTime: Double
    let dailySunsetTime: Double
    let dailyTemperatureMax: Double
    let dailyTemperatureMin: Double
    
    var temperatureString : String {
        return String(format: "%.0f", currentTemperature)
    }
    
    var feelsLikeString : String {
        return String(format: "%.0f", feelsLike)
    }
    
    var dailyTemperatureMaxString : String {
        return String(format: "%.0f", dailyTemperatureMax)
    }
    
    var dailyTemperatureMinString : String {
        return String(format: "%.0f", dailyTemperatureMin)
    }
    
    var windSpeedString : String {
        return String(format: "%.0f", windSpeed)
    }
    
    var dailySunriseTimeString : String {
        let time = NSDate(timeIntervalSince1970: dailySunriseTime)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        return timeFormatter.string(from: time as Date)
    }
    
    var dailySunsetTimeString : String {
        let time = NSDate(timeIntervalSince1970: dailySunsetTime)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        return timeFormatter.string(from: time as Date)
    }
    
    var backgroundImageCondition: String {
        switch currentIcon {
        case K.Condition.clearDay:
            return K.Condition.clearDay
        case K.Condition.clearNight:
            return K.Condition.clearNight
        case K.Condition.cloudy:
            return K.Condition.cloudy
        case K.Condition.partlyCloudyDay:
            return K.Condition.partlyCloudyDay
        case K.Condition.partlyCloudyNight:
            return K.Condition.partlyCloudyNight
        case K.Condition.fog:
            return K.Condition.fog
        case K.Condition.hail:
            return K.Condition.hail
        case K.Condition.rain:
            return K.Condition.rain
        case K.Condition.sleet:
            return K.Condition.sleet
        case K.Condition.snow:
            return K.Condition.snow
        case K.Condition.thunderstorm:
            return K.Condition.thunderstorm
        case K.Condition.tornado:
            return K.Condition.tornado
        case K.Condition.wind:
            return K.Condition.wind
        default:
            return K.Condition.partlyCloudyDay
        }
    }
    
    
}
