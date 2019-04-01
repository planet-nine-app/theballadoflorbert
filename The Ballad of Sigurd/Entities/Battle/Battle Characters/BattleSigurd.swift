//
//  BattleSigurd.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/26/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class BattleSigurd: AbstractBattleCharacter {
    
    let readyTexture = SKTexture(imageNamed: "Alien1_Rest@3x.png")
    let actionTexture = SKTexture(imageNamed: "Alien1_Fight@3x.png")
    
    override func tapped() {
        hasPriority = true
        characterNode.texture = actionTexture
    }
    
    override func relinquishPriority() {
        hasPriority = false
        characterNode.texture = readyTexture
    }
}
