//
//  BrynAttack.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 4/1/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class BrynAttack: AbstractBattleEffect {
    
    let at: CGPoint
    let to: CGPoint
    
    init(at: CGPoint, to: CGPoint) {
        self.at = at
        self.to = to
        super.init()
        node = SKSpriteNode(imageNamed: "Alien2_Weapon@3x.png")
        node.position = at
        node.zPosition = ZPositions.effect.rawValue
    }
    
    func addToSceneAndRunWithCompletion(scene: AbstractScene, completion: @escaping () -> Void) {
        scene.addChild(node)
        
        let moveAction = SKAction.move(to: to, duration: 0.3)
        let fadeAction = SKAction.fadeOut(withDuration: 0.1)
        let sequence = SKAction.sequence([moveAction, fadeAction])
        
        node.run(sequence) {
            self.node.removeFromParent()
            completion()
        }
    }
}
