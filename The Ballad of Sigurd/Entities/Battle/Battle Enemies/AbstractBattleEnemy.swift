//
//  AbstractBattleEnemy.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/25/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class AbstractBattleEnemy {
    var name = "abstract"
    var level: Int = 1
    var maxHP: Int = 50
    var currentHP: Int = 50
    var baseHP = 50
    var maxMP: Int = 16
    var currentMP: Int = 16
    var experience: Int = 0
    //stats
    var strength: Int = 8
    var vitality: Int = 8
    var agility: Int = 8
    var dexterity: Int = 8
    var wisdom: Int = 8
    var aura: Int = 8
    var perception: Int = 8
    var luck: Int = 8
    
    var spriteNode = SKSpriteNode()

    func levelUp() {
        level = level + 1
        strength = strength + Int.statIncrease()
        vitality = vitality + Int.statIncrease()
        agility = agility + Int.statIncrease()
        dexterity = dexterity + Int.statIncrease()
        wisdom = wisdom + Int.statIncrease()
        aura = aura + Int.statIncrease()
        perception = perception + Int.statIncrease()
        luck = luck + Int.statIncrease()
        
        maxHP = baseHP + (vitality * 2)
        currentHP = maxHP
        maxMP = wisdom + aura
        currentMP = maxMP
        
        print("Stats at level \(level): \(strength), \(vitality), \(agility), \(dexterity), \(wisdom), \(aura), \(perception), \(luck)")
    }
    
    func damage(_ amount: Int) {
        currentHP = currentHP - amount
        print(currentHP)
    }
}
