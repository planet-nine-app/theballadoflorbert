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
    let character1 = CGPoint(x: 180, y: 750)
    let character2 = CGPoint(x: 180, y: 500)
    let character3 = CGPoint(x: 180, y: 250)
    let enemy1 = CGPoint(x: 1520, y: 500)
}

struct BattleMath {
    func calculateSigurdDamageToEnemy(enemy: AbstractBattleEnemy, sigurd: BattleSigurd) -> Int {
        return 16
    }
    func calculateBrynDamageToEnemy(enemy: AbstractBattleEnemy, bryn: BattleBryn) -> Int {
        return 17
    }
    func calculatePhysicalEnemyDamageToCharacter(enemy: AbstractBattleEnemy, character: AbstractBattleCharacter) -> Int {
        return 18
    }
    func calculateMagicalDamageToEnemy(character: AbstractBattleCharacter, enemy: AbstractBattleEnemy) -> Int {
        return 19
    }
    func calculateMagicalDamageToCharacter(enemy: AbstractBattleEnemy, character: AbstractBattleCharacter) -> Int {
        return 20
    }
    func calculateHealingToCharacter(character: AbstractBattleCharacter, characterThatUsedRune: AbstractBattleCharacter) -> Int {
        return 21
    }
}
