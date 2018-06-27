//
//  MainViewController.swift
//  Tesla
//
//  Created by Ronan on 6/27/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    let imageHeight: CGFloat = 225
    let CellHeight: CGFloat = 56
    let imageWidth: CGFloat = 56
    
    var myCar: Car!
    var carImageView: UIImageView!
    var batteryView: BatteryView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.themeBackgroundColor()
        navigationItem.title = "Model S"
        
        setupSubviews()
    }

    func setupSubviews() {
        myCar = Car(model: .s, totalDistance: 570)
        myCar.availableDistance = 320
        // 全景图片
        carImageView = UIImageView()
        view.addSubview(carImageView)
        carImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(imageHeight)
        }
        carImageView.image = UIImage(named: "placeholder")
        
        // 电量
        batteryView = BatteryView()
        view.addSubview(batteryView)
        batteryView.snp.makeConstraints { make in
            make.top.equalTo(carImageView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(CellHeight)
        }
        
        // Conditioner
//        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: <#T##CGFloat#>)
//        let centerView = CenterView(frame: <#T##CGRect#>, items: <#T##[ButtonItem]#>)
//        let conditionerButton = UIButton()
//        view.addSubview(conditionerButton)
//        conditionerButton.snp.makeConstraints { make in
//            make.top.equalTo(batteryView.snp.bottom).offset(20)
//            make.height.equalTo(92)
//            let imageSpacing = (UIScreen.main.bounds.width - imageWidth * 2) / 4
//            make.left.equalToSuperview().offset(imageSpacing)
//        }
//        conditionerButton.setImage(UIImage(named: "home_fan_off"), for: .normal)
//        conditionerButton.setImage(UIImage(named: "home_fan_on"), for: .selected)
//        let conditionerLabel = UILabel()
//        view.addSubview(conditionerLabel)
//        conditionerLabel.snp.makeConstraints { make in
//            make.top.equalTo(conditionerButton.snp.bottom).offset(10)
//            make.centerX.equalTo(conditionerButton)
//        }
//        conditionerLabel.font = UIFont.setGotham(.big)
//        conditionerLabel.text = "26 ℃"
//
//        let lockButton = UIButton()
//        view.addSubview(lockButton)
//        lockButton.snp.makeConstraints { make in
//            make.top.equalTo(batteryView.snp.bottom).offset(20)
//            make.height.equalTo(92)
//            let imageSpacing = (UIScreen.main.bounds.width - imageWidth * 2) / 4
//            make.right.equalToSuperview().offset(-imageSpacing)
//        }
//        lockButton.setImage(UIImage(named: "home_lock_on"), for: .normal)
//        lockButton.setImage(UIImage(named: "home_lock_off"), for: .selected)
//        let lockLabel = UILabel()
//        view.addSubview(lockLabel)
//        lockLabel.snp.makeConstraints { make in
//            make.top.equalTo(lockButton.snp.bottom).offset(10)
//            make.centerX.equalTo(lockButton)
//        }
//        lockLabel.font = UIFont.setGotham(.big)
//        lockLabel.text = "Unlocked"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        batteryView.setBattery(car: myCar)
    }
}
