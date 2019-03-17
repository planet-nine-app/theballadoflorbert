//
//  InventoryItem.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/22/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import PlanetNineGateway

enum InventoryType: String {
    case weapon = "Weapon"
    case helm = "Helm"
    case bodyArmor = "BodyArmor"
    case bracers = "Bracers"
    case shield = "Shield"
    case necklace = "Necklace"
    case boots = "Boots"
    case gloves = "Gloves"
}

class InventoryItem: Comparable {
    
    
    var inventoryType: InventoryType = .weapon
    var element: Elements = .air
    var elementBoost = 0
    var stat: Stats = .strength
    var statBoost = 0
    var rarity: Rarities = .common
    var nineum: Nineum?
    
    init(inventoryType: InventoryType) {
        self.inventoryType = inventoryType
        element = .air
        stat = .agility
        rarity = .common
    }
    
    init(nineum: Nineum) {
        self.inventoryType = getInventoryTypeForNineum(nineum: nineum)
        self.element = getElementForNineum(nineum: nineum)
        self.stat = getStatForNineum(nineum: nineum)
        self.rarity = nineum.rarity
        self.nineum = nineum
    }
    
    func toString() -> String {
        
        var statModifier = "Minor"
        if statBoost > 8 {
            statModifier = "Great"
        }
        if statBoost > 14 {
            statModifier = "Super"
        }
        if statBoost > 20 {
            statModifier = "Peerless"
        }
        
        var elementModifier = "Minor"
        if elementBoost > 8 {
            elementModifier = "Great"
        }
        if elementBoost > 14 {
            elementModifier = "Super"
        }
        if elementBoost > 20 {
            elementModifier = "Peerless"
        }
        
        let article = (rarity == .uncommon || rarity == .epic) ? "An" : "A"
        
        //return "\(article) \(rarity.rawValue) \(inventoryType.rawValue) of \(statModifier) \(stat.rawValue) and \(elementModifier) \(element.rawValue)"
        
        return "\(statModifier) \(stat.rawValue)"
    }
    
    func getInventoryTypeForNineum(nineum: Nineum) -> InventoryType {
        switch nineum.size {
        case .small:
            return .weapon
        case .miniscule:
            return .helm
        case .tiny:
            return .bodyArmor
        case .standard:
            return .bracers
        case .medium:
            return .shield
        case .big:
            return .gloves
        case .large:
            return .necklace
        case .huge:
            return .boots
        }
    }
    
    func getElementForNineum(nineum: Nineum) -> Elements {
        switch nineum.texture {
        case .bumpy:
            return .air
        case .gritty:
            return .death
        case .metallic:
            return .earth
        case .plush:
            return .fire
        case .rough:
            return .life
        case .satin:
            return .metal
        case .soft:
            return .nature
        case .woolen:
            return .water
        }
    }
    
    func getStatForNineum(nineum: Nineum) -> Stats {
        switch nineum.shape {
        case .cone:
            return .agility
        case .cube:
            return .aura
        case .cylinder:
            return .dexterity
        case .dodecahedron:
            return .luck
        case .octahedron:
            return .perception
        case .sphere:
            return .strength
        case .tetrahedron:
            return .vitality
        case .torus:
            return .wisdom
        }
    }
    
    static func < (lhs: InventoryItem, rhs: InventoryItem) -> Bool {
        let lhsBoost = lhs.elementBoost + lhs.statBoost
        let rhsBoost = rhs.elementBoost + rhs.statBoost
        
        return lhsBoost < rhsBoost
    }
    
    static func == (lhs: InventoryItem, rhs: InventoryItem) -> Bool {
        let lhsBoost = lhs.elementBoost + lhs.statBoost
        let rhsBoost = rhs.elementBoost + rhs.statBoost
        
        return lhsBoost == rhsBoost
    }
}
