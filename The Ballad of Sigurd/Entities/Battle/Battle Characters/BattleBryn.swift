//
//  BattleBryn.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/26/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class BattleBryn: AbstractBattleCharacter {
    let readyTexture = SKTexture(imageNamed: "Bryn_4x_ready.png")
    let actionTexture = SKTexture(imageNamed: "Bryn_4x_attack.png")
    
    override func tapped() {
        hasPriority = true
        spriteNode.texture = actionTexture
    }
    
    override func relinquishPriority() {
        hasPriority = false
        spriteNode.texture = readyTexture
    }
}
