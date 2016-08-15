//
//  DoubleRounder.swift
//  NonStopTap
//
//  Created by Christopher Dugan on 4/19/16.
//  Copyright © 2016 ctd. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}