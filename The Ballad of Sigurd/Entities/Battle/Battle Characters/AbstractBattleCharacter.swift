//
//  AbstractBattleCharacter.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/26/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class AbstractBattleCharacter {
    let playerCharacter: AbstractPlayerCharacter
    let spriteNode: SKSpriteNode
    var hasPriority = false
    
    init(character: AbstractPlayerCharacter) {
        playerCharacter = character
        switch character.name {
        case .sigurd:
            spriteNode = SKSpriteNode(imageNamed: "Baal_ready_pose_4x.png")
            spriteNode.position = BattlePositions().character1
        case .bryn:
            spriteNode = SKSpriteNode(imageNamed: "Bryn_4x_ready.png")
            spriteNode.position = BattlePositions().character2
            //spriteNode.position = CGPoint(x: 180, y: 500)
        }
        spriteNode.name = character.name.rawValue
        spriteNode.zPosition = ZPositions.entity.rawValue
    }
    
    func tapped() {
        
    }
    
    func relinquishPriority() {
        
    }
    
    func damage(_ amount: Int, scene: BattleScene) {
        playerCharacter.currentHP = playerCharacter.currentHP - amount
        print(playerCharacter.currentHP)
        let damage = Damage(amount, location: self.spriteNode.position)
        damage.addToSceneAndRun(scene: scene)
    }
    
    func heal(_ amount: Int, scene: BattleScene) {
        playerCharacter.currentHP = playerCharacter.currentHP + amount
        if playerCharacter.currentHP > playerCharacter.maxHP {
            playerCharacter.currentHP = playerCharacter.maxHP
        }
        let healing = Healing(amount, location: self.spriteNode.position)
        healing.addToSceneAndRun(scene: scene)
    }
}

