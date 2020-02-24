//
//  LocationsViewController.swift
//  Clima
//
//  Created by Danijela Vrzan on 2020-02-13.
//  Copyright © 2020 Danijela Vrzan. All rights reserved.
//

import UIKit

class LocationsViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var textFieldHintLabel: UILabel!
    @IBOutlet weak var hintBubbleImageView: UIImageView!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        hintBubbleImageView.isHidden = true
        searchTextField.delegate = self

    }
    
}

//MARK: - UITextFieldDelegate

extension LocationsViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldHintLabel.text = "Please provide both city and country names"
        hintBubbleImageView.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let locationString = searchTextField.text {
            weatherManager.updateWeatherByCity(location: locationString)
        }
        showSpinner(onView: view)
        searchTextField.text = ""
        textFieldHintLabel.text = ""
        hintBubbleImageView.isHidden = true
    }
    
}
