//
//  BattleDialog.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 3/4/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class BattleDialog {
    let backgroundNode: SKShapeNode
    let textNode: SKLabelNode
    
    init(sizeOf: CGSize, at: CGPoint, with text: String) {
        backgroundNode = SKShapeNode(rectOf: sizeOf)
        backgroundNode.position = at
        backgroundNode.zPosition = ZPositions.effect.rawValue
        backgroundNode.fillColor = UIColor.blue
        
        textNode = SKLabelNode(text: text)
        textNode.fontColor = UIColor.white
        textNode.numberOfLines = 0
        textNode.fontSize = 48
        
        backgroundNode.addChild(textNode)
    }
    
    func addToScene(scene: AbstractScene) {
        scene.addChild(backgroundNode)
    }
}
