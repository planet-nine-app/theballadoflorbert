//
//  WoodElemental.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/27/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class WoodElemental: AbstractBattleEnemy {
    
    let readyTexture = SKTexture(imageNamed: "AlienBoss_Rest@3x.png")
    let actionTexture = SKTexture(imageNamed: "AlienBoss_Fight@3x.png")
    
    override init() {
        super.init()
        self.spriteNode = SKSpriteNode(imageNamed: "AlienBoss_Rest@3x.png")
        spriteNode.zPosition = ZPositions.entity.rawValue
    }
    
    func startAttack() {
        spriteNode.texture = actionTexture
    }
    
    func endAttack() {
        spriteNode.texture = readyTexture
    }
}
