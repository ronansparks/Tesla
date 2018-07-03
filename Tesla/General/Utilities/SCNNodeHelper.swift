//
//  SCNNodeHelper.swift
//  Tesla
//
//  Created by Ronan on 7/1/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import SceneKit

// 创建平面
func createPlaneNode(center: vector_float3,
                     extent: vector_float3) -> SCNNode {
    let plane = SCNPlane(width: CGFloat(extent.x), height: CGFloat(extent.z))
    
    let planeMaterial = SCNMaterial()
    planeMaterial.diffuse.contents = UIColor.themeGreen().withAlphaComponent(0.5)
    
    plane.materials = [planeMaterial]
    
    let planeNode = SCNNode(geometry: plane)
    planeNode.position = SCNVector3Make(center.x, 0, center.y)
    planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
    
    return planeNode
}

// 扩大平面
func updatePlaneNode(_ node: SCNNode,
                     center: vector_float3,
                     extent: vector_float3) {
    let geometry = node.geometry as? SCNPlane
    geometry?.width = CGFloat(extent.x)
    geometry?.height = CGFloat(extent.z)
    
    node.position = SCNVector3Make(center.x, 0, center.z)
}
