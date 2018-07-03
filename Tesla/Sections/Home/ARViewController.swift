//
//  ARViewController.swift
//  Tesla
//
//  Created by Ronan on 7/1/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit
import ARKit
import RxSwift
import RxCocoa

enum MessageState {
    case success
    case fail
}

@available(iOS 11.0, *)
class ARViewController: UIViewController, ARSCNViewDelegate {
    
    var sceneView: ARSCNView!
    var messageLabel: UILabel!
    var teslaNode: SCNNode? = nil
    
    var isTeslaPlaced = false
    var debugPlanes: [SCNNode] = []
    let bag = DisposeBag()
    
    var viewCenter: CGPoint {
        let viewBounds = view.bounds
        return CGPoint(x: viewBounds.width / 2.0, y: viewBounds.height / 2.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView = ARSCNView(frame: view.bounds)
        sceneView.delegate = self
        self.view.addSubview(sceneView)
        runSession()
        
        setupSubviews()
    }
    
    func setupSubviews() {
        // 退出按钮
        let exitButton = UIButton()
        exitButton.setImage(UIImage(named: "close"), for: .normal)
        self.view.addSubview(exitButton)
        exitButton.snp.makeConstraints { make in
            make.left.equalTo(UNIVERSAL_MARGIN)
            make.top.equalTo(64)
        }
        exitButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.sceneView.session.pause()
                self?.teslaNode?.removeFromParentNode()
                self?.sceneView.removeFromSuperview()
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: bag)
        
        // 提示标签
        messageLabel = UILabel()
        self.view.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        setMessageLabel(text: nil, state: nil)
    }
    
    // 设置提示标签
    func setMessageLabel(text: String?, state: MessageState?) {
        
        guard let message = text, let messageState = state else {
            messageLabel.alpha = 0
            return
        }
        
        messageLabel.text = message
        messageLabel.alpha = 1
        
        switch messageState {
        case .success:
            messageLabel.backgroundColor = UIColor.themeGreen().withAlphaComponent(0.6)
        case .fail:
            messageLabel.backgroundColor = UIColor.themeRed().withAlphaComponent(0.6)
        }
        
    }
    
    // 开始摄像头捕捉
    func runSession() {
        print(#function)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.isLightEstimationEnabled = true
        
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
        #if DEBUG
            sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
        #endif
    }
    
    // 点击放置 Tesla
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let hit = sceneView.hitTest(viewCenter, types: [.existingPlaneUsingExtent]).first {
            sceneView.session.add(anchor: ARAnchor.init(transform: hit.worldTransform))
        }
    }
    
    // 创建 Tesla Node
    func makeTesla() -> SCNNode {
        let tesla = SCNNode()
        let scene = SCNScene(named: "art.scnassets/Tesla_Model_3.dae")
        
        let rootNode = scene?.rootNode
        rootNode?.scale = SCNVector3Make(0.01, 0.01, 0.01)
        tesla.addChildNode(rootNode!)
        
        return tesla
    }
    
    // session 中断后，移除
    func removeAllNodes() {
        self.teslaNode?.removeFromParentNode()
        self.isTeslaPlaced = false
    }
    
    deinit {
        print(#function)
    }
}

@available(iOS 11.0, *)
extension ARViewController {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            if let planeAnchor = anchor as? ARPlaneAnchor, !self.isTeslaPlaced {
                #if DEBUG
                let debugPlaneNode = createPlaneNode(center: planeAnchor.center, extent: planeAnchor.extent)
                node.addChildNode(debugPlaneNode)
                self.debugPlanes.append(debugPlaneNode)
                #endif
                self.setMessageLabel(text: "点击屏幕，停放您的特斯拉", state: .success)
            }
            else if !self.isTeslaPlaced {
                self.teslaNode = self.makeTesla()
                if let tesla = self.teslaNode {
                    node.addChildNode(tesla)
                    self.isTeslaPlaced = true
                    
                    self.sceneView.debugOptions = []
                    
                    DispatchQueue.main.async {
                        self.setMessageLabel(text: nil, state: nil)
                    }
                }
            }
        }
    }
    
    // 更新平面
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            if let planeAnchor = anchor as? ARPlaneAnchor, node.childNodes.count > 0, !self.isTeslaPlaced {
                updatePlaneNode(node.childNodes[0], center: planeAnchor.center, extent: planeAnchor.extent)
            }
        }
    }
    
    // MARK: Session Handle
    func session(_ session: ARSession, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.setMessageLabel(text: "Session 加载失败", state: .fail)
        }
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        DispatchQueue.main.async {
            self.setMessageLabel(text: "Session 中断了", state: .fail)
        }
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        DispatchQueue.main.async {
            self.removeAllNodes()
            self.setMessageLabel(text: "Session 已恢复", state: .success)
        }
        
        runSession()
    }
}
