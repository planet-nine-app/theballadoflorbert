//
//  AbstractPlayerCharacter.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/22/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation

class AbstractPlayerCharacter {
    
    var name: CharacterNames
    var level: Int = 1
    var maxHP: Int = 50
    var currentHP: Int = 50
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
    //inventory
    var runes: [Rune] = [Rune]()
    var rightHand: Weapon = Weapon()
    var leftHand: Shield = Shield()
    var head: Helm = Helm()
    var body: BodyArmor = BodyArmor()
    var wrists: Bracers = Bracers()
    var hands: Gloves = Gloves()
    var feet: Boots = Boots()
    var neck: Necklace = Necklace()
    
    init(named: CharacterNames) {
        name = named
    }
    
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
        
        maxHP = 50 + (vitality * 2)
        currentHP = maxHP
        maxMP = wisdom + aura
        currentMP = maxMP
        
        print("Stats at level \(level): \(strength), \(vitality), \(agility), \(dexterity), \(wisdom), \(aura), \(perception), \(luck)")
    }
    
    func calculateDamage(enemy: AbstractBattleEnemy) -> Int? {
        let modifiedStrength = getModifiedStrength()
        let damage = modifiedStrength + Int.random(in: 1..<modifiedStrength) - enemy.vitality
        if damage < 1 {
            return nil
        }
        return damage
    }
    
    func getModifiedStrength() -> Int {
        var modifiedStrength = strength
        if rightHand.stat == .strength {
            modifiedStrength = modifiedStrength + rightHand.statBoost
        }
        if leftHand.stat == .strength {
            modifiedStrength = modifiedStrength + leftHand.statBoost
        }
        if head.stat == .strength {
            modifiedStrength = modifiedStrength + head.statBoost
        }
        if body.stat == .strength {
            modifiedStrength = modifiedStrength + body.statBoost
        }
        if wrists.stat == .strength {
            modifiedStrength = modifiedStrength + wrists.statBoost
        }
        if hands.stat == .strength {
            modifiedStrength = modifiedStrength + hands.statBoost
        }
        if neck.stat == .strength {
            modifiedStrength = modifiedStrength + neck.statBoost
        }
        if feet.stat == .strength {
            modifiedStrength = modifiedStrength + feet.statBoost
        }
        return modifiedStrength
    }
    
    func getModifiedVitality() -> Int {
        var modifiedVitality = vitality
        if rightHand.stat == .vitality {
            modifiedVitality = modifiedVitality + rightHand.statBoost
        }
        if leftHand.stat == .vitality {
            modifiedVitality = modifiedVitality + leftHand.statBoost
        }
        if head.stat == .vitality {
            modifiedVitality = modifiedVitality + head.statBoost
        }
        if body.stat == .vitality {
            modifiedVitality = modifiedVitality + body.statBoost
        }
        if wrists.stat == .vitality {
            modifiedVitality = modifiedVitality + wrists.statBoost
        }
        if hands.stat == .vitality {
            modifiedVitality = modifiedVitality + hands.statBoost
        }
        if neck.stat == .vitality {
            modifiedVitality = modifiedVitality + neck.statBoost
        }
        if feet.stat == .vitality {
            modifiedVitality = modifiedVitality + feet.statBoost
        }
        return modifiedVitality
    }
    
    func getModifiedAgility() -> Int {
        var modifiedAgility = agility
        if rightHand.stat == .agility {
            modifiedAgility = modifiedAgility + rightHand.statBoost
        }
        if leftHand.stat == .agility {
            modifiedAgility = modifiedAgility + leftHand.statBoost
        }
        if head.stat == .agility {
            modifiedAgility = modifiedAgility + head.statBoost
        }
        if body.stat == .agility {
            modifiedAgility = modifiedAgility + body.statBoost
        }
        if wrists.stat == .agility {
            modifiedAgility = modifiedAgility + wrists.statBoost
        }
        if hands.stat == .agility {
            modifiedAgility = modifiedAgility + hands.statBoost
        }
        if neck.stat == .agility {
            modifiedAgility = modifiedAgility + neck.statBoost
        }
        if feet.stat == .agility {
            modifiedAgility = modifiedAgility + feet.statBoost
        }
        return modifiedAgility
    }
    
    func getModifiedDexterity() -> Int {
        var modifiedDexterity = dexterity
        if rightHand.stat == .dexterity {
            modifiedDexterity = modifiedDexterity + rightHand.statBoost
        }
        if leftHand.stat == .dexterity {
            modifiedDexterity = modifiedDexterity + leftHand.statBoost
        }
        if head.stat == .dexterity {
            modifiedDexterity = modifiedDexterity + head.statBoost
        }
        if body.stat == .dexterity {
            modifiedDexterity = modifiedDexterity + body.statBoost
        }
        if wrists.stat == .dexterity {
            modifiedDexterity = modifiedDexterity + wrists.statBoost
        }
        if hands.stat == .dexterity {
            modifiedDexterity = modifiedDexterity + hands.statBoost
        }
        if neck.stat == .dexterity {
            modifiedDexterity = modifiedDexterity + neck.statBoost
        }
        if feet.stat == .dexterity {
            modifiedDexterity = modifiedDexterity + feet.statBoost
        }
        return modifiedDexterity
    }
    
    func getModifiedWisdom() -> Int {
        var modifiedWisdom = wisdom
        if rightHand.stat == .wisdom {
            modifiedWisdom = modifiedWisdom + rightHand.statBoost
        }
        if leftHand.stat == .wisdom {
            modifiedWisdom = modifiedWisdom + leftHand.statBoost
        }
        if head.stat == .wisdom {
            modifiedWisdom = modifiedWisdom + head.statBoost
        }
        if body.stat == .wisdom {
            modifiedWisdom = modifiedWisdom + body.statBoost
        }
        if wrists.stat == .wisdom {
            modifiedWisdom = modifiedWisdom + wrists.statBoost
        }
        if hands.stat == .wisdom {
            modifiedWisdom = modifiedWisdom + hands.statBoost
        }
        if neck.stat == .wisdom {
            modifiedWisdom = modifiedWisdom + neck.statBoost
        }
        if feet.stat == .wisdom {
            modifiedWisdom = modifiedWisdom + feet.statBoost
        }
        return modifiedWisdom
    }
    
    func getModifiedAura() -> Int {
        var modifiedAura = aura
        if rightHand.stat == .aura {
            modifiedAura = modifiedAura + rightHand.statBoost
        }
        if leftHand.stat == .aura {
            modifiedAura = modifiedAura + leftHand.statBoost
        }
        if head.stat == .aura {
            modifiedAura = modifiedAura + head.statBoost
        }
        if body.stat == .aura {
            modifiedAura = modifiedAura + body.statBoost
        }
        if wrists.stat == .aura {
            modifiedAura = modifiedAura + wrists.statBoost
        }
        if hands.stat == .aura {
            modifiedAura = modifiedAura + hands.statBoost
        }
        if neck.stat == .aura {
            modifiedAura = modifiedAura + neck.statBoost
        }
        if feet.stat == .aura {
            modifiedAura = modifiedAura + feet.statBoost
        }
        return modifiedAura
    }
    
    func getModifiedPerception() -> Int {
        var modifiedPerception = perception
        if rightHand.stat == .perception {
            modifiedPerception = modifiedPerception + rightHand.statBoost
        }
        if leftHand.stat == .perception {
            modifiedPerception = modifiedPerception + leftHand.statBoost
        }
        if head.stat == .perception {
            modifiedPerception = modifiedPerception + head.statBoost
        }
        if body.stat == .perception {
            modifiedPerception = modifiedPerception + body.statBoost
        }
        if wrists.stat == .perception {
            modifiedPerception = modifiedPerception + wrists.statBoost
        }
        if hands.stat == .perception {
            modifiedPerception = modifiedPerception + hands.statBoost
        }
        if neck.stat == .perception {
            modifiedPerception = modifiedPerception + neck.statBoost
        }
        if feet.stat == .perception {
            modifiedPerception = modifiedPerception + feet.statBoost
        }
        return modifiedPerception
    }
    
    func getModifiedLuck() -> Int {
        var modifiedLuck = luck
        if rightHand.stat == .luck {
            modifiedLuck = modifiedLuck + rightHand.statBoost
        }
        if leftHand.stat == .luck {
            modifiedLuck = modifiedLuck + leftHand.statBoost
        }
        if head.stat == .luck {
            modifiedLuck = modifiedLuck + head.statBoost
        }
        if body.stat == .luck {
            modifiedLuck = modifiedLuck + body.statBoost
        }
        if wrists.stat == .luck {
            modifiedLuck = modifiedLuck + wrists.statBoost
        }
        if hands.stat == .luck {
            modifiedLuck = modifiedLuck + hands.statBoost
        }
        if neck.stat == .luck {
            modifiedLuck = modifiedLuck + neck.statBoost
        }
        if feet.stat == .luck {
            modifiedLuck = modifiedLuck + feet.statBoost
        }
        return modifiedLuck
    }
}
