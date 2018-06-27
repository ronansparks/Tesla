//
//  Car.swift
//  Tesla
//
//  Created by Ronan on 6/27/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import Foundation

enum Model {
    case roadster
    case roadster2
    case s
    case x
    case three
}

struct Car {
    var model: Model
//    var currentBattery: Double? 电量未知，不设置；使用动态计算的续航里程
//    var totalBattery: Double
    var availableDistance: Double = 0
    var totalDistance: Double
    
    init(model: Model, totalDistance: Double) {
        self.model = model
        self.totalDistance = totalDistance
    }
}
