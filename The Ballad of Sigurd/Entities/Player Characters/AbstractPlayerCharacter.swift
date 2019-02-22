//
//  AbstractPlayerCharacter.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/22/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation

class AbstractPlayerCharacter {
    
    var name = "abstract"
    var level: Int = 0
    var maxHP: Int = 50
    var currentHP: Int = 50
    var maxMP: Int = 10
    var currentMP: Int = 10
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
    
    init() {
        
    }
}
