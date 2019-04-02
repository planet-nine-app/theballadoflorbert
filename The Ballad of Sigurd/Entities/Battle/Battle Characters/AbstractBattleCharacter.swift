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
    
    var strength = 8
    var vitality = 8
    var agility = 8
    var dexterity = 8
    var wisdom = 8
    var aura = 8
    var perception = 8
    var luck = 8
    
    init(character: AbstractPlayerCharacter) {
        playerCharacter = character
        staminaRegenerationRate = playerCharacter.maxStamina / 3
        magicRegenerationRate = playerCharacter.maxMP / 3
        var statusBarX: CGFloat = 0.0
        var statusBarY: CGFloat = 0.0
        switch character.name {
        case .sigurd:
            characterNode = SKSpriteNode(imageNamed: "Alien1_Rest@3x.png")
            spriteNode = SKShapeNode(rectOf: CGSize(width: characterNode.frame.width, height: characterNode.frame.height + 120))
            spriteNode.position = BattlePositions().character1
            statusBarX = 120
            statusBarY = spriteNode.frame.height - 420
        case .bryn:
            characterNode = SKSpriteNode(imageNamed: "Alien2_Rest@3x.png")
            spriteNode = SKShapeNode(rectOf: CGSize(width: characterNode.frame.width, height: characterNode.frame.height + 120))
            spriteNode.position = BattlePositions().character2
            //spriteNode.position = CGPoint(x: 180, y: 500)
            statusBarX = -100
            statusBarY = spriteNode.frame.height - 350
        case .anders:
            characterNode = SKSpriteNode(imageNamed: "Alien3_Rest@3x.png")
            spriteNode = SKShapeNode(rectOf: CGSize(width: characterNode.frame.width, height: characterNode.frame.height + 120))
            spriteNode.position = BattlePositions().character3
            statusBarX = -100
            statusBarY = spriteNode.frame.height - 150
        }
        statusBar = StatusBar(location: CGPoint(x: statusBarX, y: statusBarY))
        spriteNode.addChild(characterNode)
        spriteNode.addChild(statusBar.backgroundNode)
        spriteNode.lineWidth = 0
        spriteNode.name = character.name.rawValue
        spriteNode.zPosition = ZPositions.entity.rawValue
        
        calculateStats()
    }
    
    func calculateStats() {
        var statDictionary = [Stats: Int]()
        statDictionary[.strength] = playerCharacter.strength
        statDictionary[.vitality] = playerCharacter.vitality
        statDictionary[.agility] = playerCharacter.agility
        statDictionary[.dexterity] = playerCharacter.dexterity
        statDictionary[.wisdom] = playerCharacter.wisdom
        statDictionary[.aura] = playerCharacter.aura
        statDictionary[.perception] = playerCharacter.perception
        statDictionary[.luck] = playerCharacter.luck
        
        let inventory = playerCharacter.inventory
        print(inventory)
        if inventory.weapons.count > 0 {
            let stat = inventory.weapons[0].stat
            let boost = inventory.weapons[0].statBoost
            statDictionary[stat] = statDictionary[stat]! + boost
        }
        if inventory.helms.count > 0 {
            let stat = inventory.helms[0].stat
            let boost = inventory.helms[0].statBoost
            statDictionary[stat] = statDictionary[stat]! + boost
        }
        if inventory.bodyArmor.count > 0 {
            let stat = inventory.bodyArmor[0].stat
            let boost = inventory.bodyArmor[0].statBoost
            statDictionary[stat] = statDictionary[stat]! + boost
        }
        if inventory.bracers.count > 0 {
            let stat = inventory.bracers[0].stat
            let boost = inventory.bracers[0].statBoost
            statDictionary[stat] = statDictionary[stat]! + boost
        }
        if inventory.shields.count > 0 {
            let stat = inventory.shields[0].stat
            let boost = inventory.shields[0].statBoost
            statDictionary[stat] = statDictionary[stat]! + boost
        }
        if inventory.gloves.count > 0 {
            let stat = inventory.gloves[0].stat
            let boost = inventory.gloves[0].statBoost
            statDictionary[stat] = statDictionary[stat]! + boost
        }
        if inventory.necklaces.count > 0 {
            let stat = inventory.necklaces[0].stat
            let boost = inventory.necklaces[0].statBoost
            statDictionary[stat] = statDictionary[stat]! + boost
        }
        if inventory.boots.count > 0 {
            let stat = inventory.boots[0].stat
            let boost = inventory.boots[0].statBoost
            statDictionary[stat] = statDictionary[stat]! + boost
        }
        
        strength = statDictionary[.strength]!
        agility = statDictionary[.agility]!
        dexterity = statDictionary[.dexterity]!
        vitality = statDictionary[.vitality]!
        wisdom = statDictionary[.wisdom]!
        aura = statDictionary[.aura]!
        perception = statDictionary[.perception]!
        luck = statDictionary[.luck]!
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

