//
//  Structs.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/26/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import UIKit

struct BattlePositions {
    let character1 = CGPoint(x: 250, y: 850)
    let character2 = CGPoint(x: 250, y: 400)
    let character3 = CGPoint(x: 550, y: 250)
    let enemy1 = CGPoint(x: 1520, y: 500)
}

struct BattleMath {
    
    func isLucky(character: AbstractBattleCharacter) -> Bool {
        let roll = Int.random(in: 1...100)
        if roll < character.luck {
            return true
        }
        return false
    }
    
    func modifyPhysicalAttack(damage: Int, character: AbstractBattleCharacter) -> Int {
        let modifier = character.playerCharacter.currentStamina > 0 ? character.playerCharacter.currentStamina / character.playerCharacter.maxStamina : 0
        var damageDouble = Double(damage) * modifier
        if isLucky(character: character) {
            damageDouble = damageDouble + Double(character.luck)
        }
        return Int(damageDouble.rounded())
    }
    
    func modifyMagicalDamage(damage: Int, character: AbstractBattleCharacter) -> Int {
        let modifier = character.playerCharacter.currentMP > 0 ? character.playerCharacter.currentMP / character.playerCharacter.maxMP : 0
        var damageDouble = Double(damage) * modifier
        if isLucky(character: character) {
            damageDouble = damageDouble + Double(character.luck)
        }
        return Int(damageDouble.rounded())
    }
    
    func calculateSigurdDamageToEnemy(enemy: AbstractBattleEnemy, sigurd: BattleSigurd) -> Int {
        let unmodifiedDamage = sigurd.strength + ((sigurd.agility + sigurd.dexterity) / 2)
        return modifyPhysicalAttack(damage: unmodifiedDamage, character: sigurd)
    }
    func calculateBrynDamageToEnemy(enemy: AbstractBattleEnemy, bryn: BattleBryn) -> Int {
        let unmodifiedDamage = ((bryn.strength + bryn.agility) / 2) + bryn.wisdom
        return modifyPhysicalAttack(damage: unmodifiedDamage, character: bryn)
    }
    func calculateAndersDamageToEnemy(enemy: AbstractBattleEnemy, anders: BattleAnders) -> Int {
        let unmodifiedDamage = ((anders.perception + anders.dexterity) / 2) + anders.aura
        return modifyPhysicalAttack(damage: unmodifiedDamage, character: anders)
    }
    func calculatePhysicalEnemyDamageToCharacter(enemy: AbstractBattleEnemy, character: AbstractBattleCharacter) -> Int {
        return 18
    }
    func calculateMagicalDamageToEnemy(character: AbstractBattleCharacter, enemy: AbstractBattleEnemy) -> Int {
        return modifyMagicalDamage(damage: 19, character: character)
    }
    func calculateMagicalDamageToCharacter(enemy: AbstractBattleEnemy, character: AbstractBattleCharacter) -> Int {
        return 20
    }
    func calculateHealingToCharacter(character: AbstractBattleCharacter, characterThatUsedRune: AbstractBattleCharacter) -> Int {
        return modifyMagicalDamage(damage: 21, character: characterThatUsedRune)
    }
}

struct Party {
    let sigurd = AbstractPlayerCharacter(named: .sigurd)
    let bryn = AbstractPlayerCharacter(named: .bryn)
    let anders = AbstractPlayerCharacter(named: .anders)
}
