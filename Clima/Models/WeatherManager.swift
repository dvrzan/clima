//
//  WeatherManager.swift
//  Clima
//
//  Created by Danijela Vrzan on 2020-01-20.
//  Copyright © 2020 Danijela Vrzan. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didUpdateLocationName(location: CLPlacemark)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = K.weatherURL
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(withLocation location: CLLocationCoordinate2D) {
        let urlString = "\(weatherURL)/\(location.latitude),\(location.longitude)?units=\(K.metricUnits)"
        performRequest(with: urlString)
    }
    
    func updateWeatherByCity(location: String) {
        CLGeocoder().geocodeAddressString(location) { placemarks, error in
            if error != nil {
                self.delegate?.didFailWithError(error: ErrorFound.invalidCity) // This error when no internet and wrong location string!
                return
            }
            if let location = placemarks?[0].location {
                self.fetchWeather(withLocation: location.coordinate)
            }
            if let placemark = placemarks?[0] {
                self.delegate?.didUpdateLocationName(location: placemark)
            }

        }
    }
    
    func getCurrentLocationName(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if error != nil {
                self.delegate?.didFailWithError(error: ErrorFound.currentLocationError)
                return
            }
            if let placemark = placemarks?[0] {
                self.delegate?.didUpdateLocationName(location: placemark)
            }
        }
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: ErrorFound.noInternetConnection) // This never triggers!
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let lat = decodedData.latitude
            let long = decodedData.longitude
            let description = decodedData.currently.summary
            let currentConditionIcon = decodedData.currently.icon
            let temp = decodedData.currently.temperature
            let realFeel = decodedData.currently.apparentTemperature
            let wind = decodedData.currently.windSpeed
            let sunrise = decodedData.daily.data[0].sunriseTime
            let sunset = decodedData.daily.data[0].sunsetTime
            let dailyTempMax = decodedData.daily.data[0].temperatureMax // Loop
            let dailyTempMin = decodedData.daily.data[0].temperatureMin //Loop
            
            let weather = WeatherModel(latitude: lat, longitude: long, currentSummary: description, currentIcon: currentConditionIcon, currentTemperature: temp, feelsLike: realFeel, windSpeed: wind, dailySunriseTime: sunrise, dailySunsetTime: sunset, dailyTemperatureMax: dailyTempMax, dailyTemperatureMin: dailyTempMin)
            
            return weather
            
        } catch {
            delegate?.didFailWithError(error: ErrorFound.noInternetConnection)
            return nil
        }
    }
    
    
}
