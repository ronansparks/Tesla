//
//  BatteryView.swift
//  Tesla
//
//  Created by Ronan on 6/27/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit

enum BatteryLevel {
    case low
    case warning
    case normal
}

class BatteryView: UIView {
    
    var fillLayer = CALayer()
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(fillLayer)
        
        setupSubviews()
    }
    
    func setupSubviews() {
        
        titleLabel = UILabel()
        addSubview(titleLabel)
        titleLabel.font = UIFont.setGotham(.middleTitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBattery(car: Car) {
        let percentage = car.availableDistance / car.totalDistance
        if percentage < 0.1 {
            setFillLayer(value: percentage, level: .low)
        }
        else if percentage < 0.3 {
            setFillLayer(value: percentage, level: .warning)
        }
        else {
            setFillLayer(value: percentage, level: .normal)
        }
        let displayDistance = Int(car.availableDistance)
        titleLabel.text = "\(displayDistance) km"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // 设置电量、颜色
    fileprivate func setFillLayer(value: Double, level: BatteryLevel) {
        switch level {
        case .low:
            fillLayer.backgroundColor = UIColor.themeRed().cgColor
        case .warning:
            fillLayer.backgroundColor = UIColor.themeYellow().cgColor
        case .normal:
            fillLayer.backgroundColor = UIColor.themeGreen().cgColor
        }
        let newFrame = CGRect(x: 0, y: 0, width: (CGFloat(value) * self.bounds.width), height: self.bounds.height)
        fillLayer.frame = newFrame
    }
    
}
