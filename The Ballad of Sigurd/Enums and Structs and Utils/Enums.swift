//
//  Enums.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/22/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import UIKit

enum Direction {
    case none
    case left
    case upLeft
    case up
    case upRight
    case right
    case downRight
    case down
    case downLeft
}

enum Elements: String {
    case water = "Water"
    case fire = "Fire"
    case air = "Air"
    case earth = "Earth"
    case nature = "Nature"
    case metal = "Metal"
    case life = "Life"
    case death = "Death"
}

enum Stats: String {
    case strength = "Strength"
    case vitality = "Vitality"
    case agility = "Agility"
    case dexterity = "Dexterity"
    case wisdom = "Wisdom"
    case aura = "Aura"
    case perception = "Perception"
    case luck = "Luck"
}

enum CharacterNames: String {
    case sigurd = "Sigurd"
    case bryn = "Bryn"
}

enum EnemyNames: String {
    case enemy1 = "Enemy1"
    case enemy2 = "Enemy2"
    case enemy3 = "Enemy3"
    case enemy4 = "Enemy4"
}

enum Runes: String {
    case none = "None"
    case vestri = "Vestri"
    case isa = "Isa"
    case ansuz = "Ansuz"
}

enum ZPositions: CGFloat {
    case background = 0.0
    case runeNode = 0.1
    case entity = 1.0
    case rune = 2.0
    case effect = 3.0
}

enum InventorySelections: String {
    case weapon = "Weapon"
    case helm = "Helm"
    case bodyArmor = "Body Armor"
    case bracers = "Bracer"
    case shield = "Shield"
    case gloves = "Gloves"
    case necklace = "Necklace"
    case boots = "Boots"
}


