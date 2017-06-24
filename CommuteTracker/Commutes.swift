//
//  Commutes.swift
//  CommuteTracker
//
//  Created by Robert Ryder on 6/22/17.
//  Copyright © 2017 Robert Ryder. All rights reserved.
//

import Foundation

class Commutes {
    
    var distance: Double? = nil
    var title: String? = "None"
    var transportType: String? = "None"
    var date = 0
    var time = 0.00
    var key = ""
    
    func isFilled() -> Bool {
        if (distance != nil) && (title != nil) && (transportType != nil) {
            return true
        } else {
            return false
        }
    }
}
