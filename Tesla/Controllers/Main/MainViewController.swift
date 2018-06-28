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
        
        // 空调按钮
        let fanContent = ButtonContent(normalImage: "home_fan_off", normalText: "26 ℃", selectedImage: "home_fan_on", selectedText: "20℃ xxxxx")
        let fanFrame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH / 2, height: 129)
        let fanButton = CenterButton(frame: fanFrame, content: fanContent)
        view.addSubview(fanButton)
        fanButton.snp.makeConstraints { make in
            make.top.equalTo(batteryView.snp.bottom).offset(UNIVERSAL_MARGIN)
            make.centerX.equalTo(SCREEN_WIDTH / 4)
        }
        
        // 锁车/解锁
        let lockContent = ButtonContent(normalImage: "home_lock", normalText: "Locked", selectedImage: "home_unlock", selectedText: "unlocked")
        let lockFrame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH / 2, height: 129)
        let lockButton = CenterButton(frame: lockFrame, content: lockContent)
        view.addSubview(lockButton)
        lockButton.snp.makeConstraints { make in
            make.top.equalTo(batteryView.snp.bottom).offset(UNIVERSAL_MARGIN)
            make.centerX.equalTo(SCREEN_WIDTH / 4 * 3)
        }
        
        // 地图
        let mapView = UIView()
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(UNIVERSAL_RADIUS)
            make.bottom.equalToSuperview().offset(-(self.tabBarController?.tabBar.frame.size.height)!)
        }
        mapView.backgroundColor = UIColor.themeBackgroundColor()
        mapView.layer.shadowColor = UIColor.themeShadowColor().cgColor
        mapView.layer.shadowOffset = CGSize(width: 0, height: 2)
        mapView.layer.shadowOpacity = 0.4
        mapView.layer.shadowRadius = 4.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        batteryView.setBattery(car: myCar)
    }
    
    deinit {
        print("MainViewController deinit")
    }
}
