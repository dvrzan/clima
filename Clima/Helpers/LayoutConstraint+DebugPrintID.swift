//
//  LayoutConstraint+DebugPrintID.swift
//  Clima
//
//  Created by Danijela Vrzan on 2020-01-22.
//  Copyright © 2020 Danijela Vrzan. All rights reserved.
//

import UIKit

//Debug constraint issues
extension NSLayoutConstraint {

    override public var description: String {
        let id = identifier ?? ""
        return "ID: \(id)"
    }
}
