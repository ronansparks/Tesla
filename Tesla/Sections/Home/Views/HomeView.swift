//
//  HomeView.swift
//  Tesla
//
//  Created by Ronan on 7/2/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit
import SceneKit
import RxSwift
import RxCocoa

class HomeView: UIView {
    
    fileprivate var sceneView: SCNView!
    var sceneButton: UIButton!
    
    fileprivate var batteryContainer: UIView!
    fileprivate var distanceLayer: CALayer!
    fileprivate var distanceLabel: UILabel!
    fileprivate(set) var fanButton: CenterButton!
    fileprivate(set) var lockButton: CenterButton!
    
    var distanceText: String = "" {
        didSet {
            distanceLabel.text = distanceText
        }
    }
    
    var distanceBackgroundColor: CGColor = UIColor.white.cgColor {
        didSet {
            distanceLayer.backgroundColor = distanceBackgroundColor
        }
    }
    
    var distancePercentage: Double = 0 {
        didSet {
            let newFrame = CGRect(x: 0, y: 0, width: self.frame.width * CGFloat(distancePercentage), height: UNIVERSAL_RADIUS)
            distanceLayer.frame = newFrame
        }
    }
    
    var insideDegree: String = "" {
        didSet {
            fanButton.setTitle(insideDegree, for: .normal)
            fanButton.setTitle(insideDegree, for: .selected)
        }
    }
    
    let sceneHeight: CGFloat = 225
    let bag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupScene()
        setupBatteryView()
        setupShortcutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 顶部 VR / AR
    func setupScene() {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.zFar = 600
        cameraNode.position = SCNVector3Make(0, 100, 200)
        
        let scene = SCNScene(named: "art.scnassets/Blue.dae")
        scene?.rootNode.scale = SCNVector3Make(2, 2, 2)
        
        sceneView = SCNView()
        self.addSubview(sceneView)
        sceneView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(sceneHeight)
        }
        sceneView.scene = scene
        sceneView.backgroundColor = UIColor.white
        sceneView.allowsCameraControl = true
        
        sceneButton = UIButton()
        self.addSubview(sceneButton)
        sceneButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-UNIVERSAL_MARGIN)
            make.bottom.equalTo(sceneView).offset(-UNIVERSAL_MARGIN)
        }
        if #available(iOS 11, *) {
            sceneButton.setImage(UIImage(named: "home_ar"), for: .normal)
        }
        else {
            sceneButton.setImage(UIImage(named: "home_360"), for: .normal)
            sceneButton.isEnabled = false
        }
    }
    
    func setupBatteryView() {
        batteryContainer = UIView()
        self.addSubview(batteryContainer)
        batteryContainer.snp.makeConstraints { make in
            make.top.equalTo(sceneView.snp.bottom)
            make.height.equalTo(UNIVERSAL_RADIUS)
            make.left.right.equalToSuperview()
        }
        distanceLayer = CALayer()
        batteryContainer.layer.addSublayer(distanceLayer)
        
        distanceLabel = UILabel()
        batteryContainer.addSubview(distanceLabel)
        distanceLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        distanceLabel.font = UIFont.setGotham(.middleTitle)
    }
    
    func setupShortcutView() {
        // 空调按钮
//        let fanContent = ButtonContent(normalImage: "home_fan_off", normalText: "26 ℃", selectedImage: "home_fan_on", selectedText: "22℃")
        let fanContent = ButtonContent(normalImage: "home_fan_off", normalText: "", selectedImage: "home_fan_on", selectedText: "")
        let fanFrame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH / 2, height: 129)
        fanButton = CenterButton(frame: fanFrame, content: fanContent)
        self.addSubview(fanButton)
        fanButton.snp.makeConstraints { make in
            make.top.equalTo(batteryContainer.snp.bottom).offset(UNIVERSAL_MARGIN)
            make.centerX.equalTo(SCREEN_WIDTH / 4)
        }
        
        // 锁车/解锁
        let lockContent = ButtonContent(normalImage: "home_lock", normalText: "Locked", selectedImage: "home_unlock", selectedText: "Unlocked")
        let lockFrame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH / 2, height: 129)
        lockButton = CenterButton(frame: lockFrame, content: lockContent)
        self.addSubview(lockButton)
        lockButton.snp.makeConstraints { make in
            make.top.equalTo(batteryContainer.snp.bottom).offset(UNIVERSAL_MARGIN)
            make.centerX.equalTo(SCREEN_WIDTH / 4 * 3)
        }
    }
}
