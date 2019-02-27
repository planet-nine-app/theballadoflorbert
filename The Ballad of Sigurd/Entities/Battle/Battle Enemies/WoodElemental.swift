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
    
    override init() {
        super.init()
        self.spriteNode = SKSpriteNode(imageNamed: "wood_elemental_4x_game.png")
        spriteNode.zPosition = ZPositions.entity.rawValue
    }
}
