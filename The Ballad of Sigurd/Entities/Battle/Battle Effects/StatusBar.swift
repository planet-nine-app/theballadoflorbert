//
//  StatusBar.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 3/4/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class StatusBar {
    let backgroundNode: SKShapeNode
    var healthNode: SKShapeNode
    var staminaNode: SKShapeNode
    var magicNode: SKShapeNode
    let nodeSize = CGSize(width: 300, height: 36)
    let healthNodeSize = CGSize(width: 180, height: 12)
    let otherNodeSize = CGSize(width: 180, height: 12)
    
    init(location: CGPoint) {
        backgroundNode = SKShapeNode(rectOf: nodeSize)
        backgroundNode.position = location
        backgroundNode.zPosition = ZPositions.entity.rawValue
        backgroundNode.lineWidth = 0
        
        healthNode = SKShapeNode(rectOf: healthNodeSize)
        healthNode.position = CGPoint(x: 0, y: 30)
        healthNode.fillColor = UIColor.StatusBarColors.health
        healthNode.glowWidth = 0
        healthNode.lineWidth = 0
        
        staminaNode = SKShapeNode(rectOf: otherNodeSize)
        staminaNode.position = CGPoint(x: 0, y: 18)
        staminaNode.fillColor = UIColor.StatusBarColors.stamina
        staminaNode.lineWidth = 0
        
        magicNode = SKShapeNode(rectOf: otherNodeSize)
        magicNode.position = CGPoint(x: 0, y: 6)
        magicNode.fillColor = UIColor.StatusBarColors.magic
        magicNode.lineWidth = 0
        
        backgroundNode.addChild(healthNode)
        backgroundNode.addChild(staminaNode)
        backgroundNode.addChild(magicNode)
    }
    
    func updateStatusBar(staminaRatio: Double, magicRatio: Double) {
        let staminaWidth = staminaRatio > 0 ? otherNodeSize.width * CGFloat(staminaRatio) : 0
        let magicWidth = magicRatio > 0 ? otherNodeSize.width * CGFloat(magicRatio) : 0
        staminaNode.removeFromParent()
        magicNode.removeFromParent()
        staminaNode = SKShapeNode(rectOf: CGSize(width: staminaWidth, height: 12))
        let staminaXDiff = (otherNodeSize.width - staminaNode.frame.width) / 2
        staminaNode.position = CGPoint(x: 0 - staminaXDiff, y: 18)
        staminaNode.fillColor = UIColor.StatusBarColors.stamina
        staminaNode.lineWidth = 0
        magicNode = SKShapeNode(rectOf: CGSize(width: magicWidth, height: 12))
        let magicXDiff = (otherNodeSize.width - magicNode.frame.width) / 2
        magicNode.position = CGPoint(x: 0 - magicXDiff, y: 6)
        magicNode.fillColor = UIColor.StatusBarColors.magic
        magicNode.lineWidth = 0
        backgroundNode.addChild(staminaNode)
        backgroundNode.addChild(magicNode)
    }
}
