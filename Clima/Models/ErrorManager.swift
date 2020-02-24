//
//  ErrorManager.swift
//  Clima
//
//  Created by Danijela Vrzan on 2020-01-28.
//  Copyright © 2020 Danijela Vrzan. All rights reserved.
//

import Foundation

enum ErrorFound: Error {
    case invalidCity
    case noInternetConnection
    case currentLocationError
    case locationServicesDenied
}

extension ErrorFound: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .invalidCity:
            return NSLocalizedString("Invalid city name; please try again.", comment: "Invalid city name")
        case .noInternetConnection:
            return NSLocalizedString("No internet connection; please check your connection and try again.", comment: "No internet connection")
        case .currentLocationError:
            return NSLocalizedString("Unable to load your location; location unknown.", comment: "Current location error")
        case .locationServicesDenied:
            return NSLocalizedString("Location services denied; please enable location services in settings.", comment: "Location services denied")
        }
    }
    
}
