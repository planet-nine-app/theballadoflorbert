//
//  InventoryButton.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 4/2/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class InventoryButton {
    
    let backingNode: SKShapeNode
    
    init() {
        backingNode = SKShapeNode(path: CGPath(roundedRect: CGRect(x: 0, y: 0, width: 374, height: 84), cornerWidth: 42, cornerHeight: 42, transform: nil))
        backingNode.fillColor = UIColor.white
        backingNode.lineWidth = 0
        backingNode.zPosition = 105.0
        backingNode.name = "Inventory"
        
        let labelNode = SKLabelNode(text: "View Inventory")
        labelNode.fontName = "Orbitron-Bold"
        labelNode.fontColor = UIColor.PlanetNineColors.primary
        labelNode.fontSize = 36
        labelNode.position = CGPoint(x: 24, y: 32)
        labelNode.zPosition = 106.0
        labelNode.horizontalAlignmentMode = .left
        
        backingNode.addChild(labelNode)
    }
}
