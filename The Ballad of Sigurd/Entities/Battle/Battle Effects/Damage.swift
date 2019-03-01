//
//  Damage.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/27/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Damage: AbstractBattleEffect {
    
    init(_ amount: Int, location: CGPoint) {
        super.init()
        
        if amount == 0 {
            node = SKLabelNode(text: "Miss")
        } else {
            node = SKLabelNode(text: "\(amount)")
        }
        let labelNode = node as! SKLabelNode
        labelNode.position = location
        labelNode.fontName = "Ubuntu-Medium"
        labelNode.fontSize = 160
        labelNode.fontColor = UIColor.orange
        node = labelNode
        
        node.zPosition = ZPositions.effect.rawValue
    }
    
    func addToSceneAndRun(scene: AbstractScene) {
        scene.addChild(node)
        let randomX = Int.plusOrMinus() * Int.random(in: 50..<200)
        let damageVelocity = CGVector(dx: randomX, dy: 500)
        node.physicsBody = SKPhysicsBody()
        node.physicsBody?.applyImpulse(damageVelocity)
        let fadeOutAction = SKAction.fadeOut(withDuration: 1)
        node.run(fadeOutAction) {
            self.node.removeFromParent()
        }
    }
}
