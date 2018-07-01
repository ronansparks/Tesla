//
//  MainViewController.swift
//  Tesla
//
//  Created by Ronan on 6/27/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import ARKit

class MainViewController: UIViewController {

    let topHeight: CGFloat = 225
    let CellHeight: CGFloat = 56
    let imageWidth: CGFloat = 56
    
    var myCar: Car!
    
    var topContainerView: UIView!
    var batteryView: BatteryView!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.themeBackgroundColor()
        navigationItem.title = "Model S"
        
        setupSubviews()
    }

    func setupSubviews() {
        myCar = Car(model: .s, totalDistance: 570)
        myCar.availableDistance = 320
        
        topContainerView = UIView()
        self.view.addSubview(topContainerView)
        topContainerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(topHeight)
        }
        topContainerView.isUserInteractionEnabled = true
        
        setupScene()
        
        let button = UIButton()
        topContainerView.addSubview(button)
        button.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-UNIVERSAL_MARGIN)
            make.bottom.equalToSuperview().offset(-UNIVERSAL_MARGIN)
        }

        if #available(iOS 11, *) {
            let arVC = ARViewController()
            button.setImage(UIImage(named: "home_ar"), for: .normal)
            button.rx.tap
                .subscribe(onNext: { [weak self] _ in
                    self?.present(arVC, animated: true, completion: nil)
                })
                .disposed(by: bag)
        }
        else {
            button.setImage(UIImage(named: "home_360"), for: .normal)
            button.isEnabled = false
        }
        
        // 电量
        batteryView = BatteryView()
        view.addSubview(batteryView)
        batteryView.snp.makeConstraints { make in
            make.top.equalTo(topContainerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(CellHeight)
        }
        
        // 空调按钮
        let fanContent = ButtonContent(normalImage: "home_fan_off", normalText: "26 ℃", selectedImage: "home_fan_on", selectedText: "22℃")
        let fanFrame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH / 2, height: 129)
        let fanButton = CenterButton(frame: fanFrame, content: fanContent)
        view.addSubview(fanButton)
        fanButton.snp.makeConstraints { make in
            make.top.equalTo(batteryView.snp.bottom).offset(UNIVERSAL_MARGIN)
            make.centerX.equalTo(SCREEN_WIDTH / 4)
        }
        
        // 锁车/解锁
        let lockContent = ButtonContent(normalImage: "home_lock", normalText: "Locked", selectedImage: "home_unlock", selectedText: "Unlocked")
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
    
    func setupScene() {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.zFar = 600
        cameraNode.position = SCNVector3Make(0, 100, 200)
        
        let scene = SCNScene(named: "art.scnassets/Model3.dae")
        scene?.rootNode.scale = SCNVector3Make(2, 2, 2)
        
        let sceneView = SCNView()
        self.topContainerView.addSubview(sceneView)
        sceneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        sceneView.scene = scene
        sceneView.backgroundColor = UIColor.white
        sceneView.allowsCameraControl = true
    }
    
    deinit {
        print("MainViewController deinit")
    }
}
