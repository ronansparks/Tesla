//
//  HomeViewModel.swift
//  Tesla
//
//  Created by Ronan on 7/2/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit

enum BatteryLevel {
    case low
    case warning
    case normal
}

struct DistanceModel {
    let text: String
    let fillPercentage: Double
    let fillColor: CGColor
}

struct HomeViewModel {
    var carModel: Car
    
    var distance: DistanceModel {
        let percentage = carModel.availableDistance / carModel.totalDistance
        var color: CGColor
        if percentage < 0.1 {
            color = UIColor.themeRed().cgColor
        }
        else if percentage < 0.3 {
            color = UIColor.themeYellow().cgColor
        }
        else {
            color = UIColor.themeGreen().cgColor
        }
        return DistanceModel(text: "\(carModel.availableDistance) km", fillPercentage: percentage, fillColor: color)
    }

    var degree: String {
        return String(carModel.insideDegree)
    }
}
