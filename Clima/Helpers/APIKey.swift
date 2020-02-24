//
//  APIKey.swift
//  Clima
//
//  Created by Danijela Vrzan on 2020-01-28.
//  Copyright © 2020 Danijela Vrzan. All rights reserved.
//

import Foundation

func valueForAPIKey(named keyname:String) -> String {
    let filePath = Bundle.main.path(forResource: "APIKey", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: keyname) as! String
    
    return value
}
