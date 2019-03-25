//
//  ExitButton.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 3/25/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class ExitButton {
    
    let topLevelZPosition: CGFloat = 105.0
    let xZPosition: CGFloat = 106.0
    var exitNode: SKShapeNode
    
    init() {
        exitNode = SKShapeNode(circleOfRadius: 14)
        exitNode.fillColor = UIColor.white
        exitNode.lineWidth = 0
        exitNode.zPosition = topLevelZPosition
        exitNode.name = "exit"
        
        let xNode = SKLabelNode(text: "X")
        xNode.fontName = "Orbitron-Bold"
        xNode.fontColor = UIColor.PlanetNineColors.primary
        xNode.fontSize = 16
        xNode.position = CGPoint(x: 0, y: -5)
        xNode.zPosition = xZPosition
        
        exitNode.addChild(xNode)
    }
}
