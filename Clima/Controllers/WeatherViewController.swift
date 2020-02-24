//
//  WeatherViewController.swift
//  Clima
//
//  Created by Danijela Vrzan on 2020-01-10.
//  Copyright © 2020 Danijela Vrzan. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    //Current weather  - main
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var conditionBackgroundImageView: UIImageView!
    
    //Current weather  - detail labels
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var realFeelTemperatureLabel: UILabel!
    
    //Other view elements
    
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        
        showSpinner(onView: view)

    }
    
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString + K.degree
            self.conditionBackgroundImageView.image = UIImage(named: weather.backgroundImageCondition)
            self.conditionLabel.text = weather.currentSummary
            self.maxTemperatureLabel.text = weather.dailyTemperatureMaxString + K.degree
            self.minTemperatureLabel.text = weather.dailyTemperatureMinString + K.degree
            self.sunriseLabel.text = weather.dailySunriseTimeString
            self.sunsetLabel.text = weather.dailySunsetTimeString
            self.windSpeedLabel.text = weather.windSpeedString + " km/h"
            self.realFeelTemperatureLabel.text = weather.feelsLikeString + K.degree
        }
        removeSpinner()
    }
    
    func didUpdateLocationName(location: CLPlacemark) {
        DispatchQueue.main.async {
            self.cityLabel.text = location.locality
            self.countryLabel.text = location.country
        }
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: K.Error.title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: K.Error.action, style: .default))
            self.present(alert, animated: true)
        }
        removeSpinner()
    }
    
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            locationManager.stopUpdatingLocation()
            
            weatherManager.fetchWeather(withLocation: lastLocation.coordinate)
            weatherManager.getCurrentLocationName(location: lastLocation)
        }
        removeSpinner()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let CLocationError = error as? CLError {
            switch CLocationError {
            case CLError.locationUnknown:
                didFailWithError(error: ErrorFound.currentLocationError)
            case CLError.denied:
                didFailWithError(error: ErrorFound.locationServicesDenied)
            case CLError.network:
                didFailWithError(error: ErrorFound.noInternetConnection)
            default:
                print("No error")
            }
        }
    }
    
}

//MARK: - UIView + Activity Indicator View

var vSpinner : UIView?

extension UIViewController {
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.color = .white
        ai.center = spinnerView.center
        ai.startAnimating()
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
}

