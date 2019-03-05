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
    let spriteNode: SKShapeNode
    let characterNode: SKSpriteNode
    let statusBar: StatusBar
    var hasPriority = false
    var staminaRegenerationRate: Double
    var magicRegenerationRate: Double
    
    init(character: AbstractPlayerCharacter) {
        playerCharacter = character
        staminaRegenerationRate = playerCharacter.maxStamina / 3
        magicRegenerationRate = playerCharacter.maxMP / 3
        switch character.name {
        case .sigurd:
            characterNode = SKSpriteNode(imageNamed: "Baal_ready_pose_4x.png")
            spriteNode = SKShapeNode(rectOf: CGSize(width: characterNode.frame.width, height: characterNode.frame.height + 120))
            spriteNode.position = BattlePositions().character1
        case .bryn:
            characterNode = SKSpriteNode(imageNamed: "Bryn_4x_ready.png")
            spriteNode = SKShapeNode(rectOf: CGSize(width: characterNode.frame.width, height: characterNode.frame.height + 120))
            spriteNode.position = BattlePositions().character2
            //spriteNode.position = CGPoint(x: 180, y: 500)
        }
        statusBar = StatusBar(location: CGPoint(x: 0, y: spriteNode.frame.height - 300))
        spriteNode.addChild(characterNode)
        spriteNode.addChild(statusBar.backgroundNode)
        spriteNode.lineWidth = 0
        spriteNode.name = character.name.rawValue
        spriteNode.zPosition = ZPositions.entity.rawValue
    }
    
    func tapped() {
        
    }
    
    func relinquishPriority() {
        
    }
    
    func damage(_ amount: Int, scene: BattleScene) {
        playerCharacter.currentHP = playerCharacter.currentHP - Double(amount)
        print(playerCharacter.currentHP)
        let damage = Damage(amount, location: self.spriteNode.position)
        damage.addToSceneAndRun(scene: scene)
    }
    
    func heal(_ amount: Int, scene: BattleScene) {
        playerCharacter.currentHP = playerCharacter.currentHP + Double(amount)
        if playerCharacter.currentHP > playerCharacter.maxHP {
            playerCharacter.currentHP = playerCharacter.maxHP
        }
        let healing = Healing(amount, location: self.spriteNode.position)
        healing.addToSceneAndRun(scene: scene)
    }
    
    func updateStatusBar(_ timeDiff: Double) {
        let staminaRegenerationAmount = timeDiff * staminaRegenerationRate
        let magicRegenerationAmount = timeDiff * magicRegenerationRate
        playerCharacter.currentStamina = playerCharacter.currentStamina + staminaRegenerationAmount
        if playerCharacter.currentStamina > playerCharacter.maxStamina {
            playerCharacter.currentStamina = playerCharacter.maxStamina
        }
        playerCharacter.currentMP = playerCharacter.currentMP + magicRegenerationAmount
        if playerCharacter.currentMP > playerCharacter.maxMP {
            playerCharacter.currentMP = playerCharacter.maxMP
        }
        let staminaRatio = playerCharacter.currentStamina / playerCharacter.maxStamina
        let magicRatio = playerCharacter.currentMP / playerCharacter.maxMP
        statusBar.updateStatusBar(staminaRatio: staminaRatio, magicRatio: magicRatio)
    }
}

