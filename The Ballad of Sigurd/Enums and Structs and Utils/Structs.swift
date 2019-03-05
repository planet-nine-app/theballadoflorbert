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
    let character1 = CGPoint(x: 180, y: 950)
    let character2 = CGPoint(x: 180, y: 500)
    let character3 = CGPoint(x: 180, y: 50)
    let enemy1 = CGPoint(x: 1520, y: 500)
}

struct BattleMath {
    
    func modifyPhysicalAttack(damage: Int, character: AbstractBattleCharacter) -> Int {
        let modifier = character.playerCharacter.currentStamina > 0 ? character.playerCharacter.currentStamina / character.playerCharacter.maxStamina : 0
        let damageDouble = Double(damage) * modifier
        return Int(damageDouble.rounded())
    }
    
    func modifyMagicalDamage(damage: Int, character: AbstractBattleCharacter) -> Int {
        let modifier = character.playerCharacter.currentMP > 0 ? character.playerCharacter.currentMP / character.playerCharacter.maxMP : 0
        let damageDouble = Double(damage) * modifier
        return Int(damageDouble.rounded())
    }
    
    func calculateSigurdDamageToEnemy(enemy: AbstractBattleEnemy, sigurd: BattleSigurd) -> Int {
        return modifyPhysicalAttack(damage: 16, character: sigurd)
    }
    func calculateBrynDamageToEnemy(enemy: AbstractBattleEnemy, bryn: BattleBryn) -> Int {
        return modifyPhysicalAttack(damage: 17, character: bryn)
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
