//
//  Shield.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/22/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import PlanetNineGateway

class Shield: InventoryItem {
    init() {
        super.init(inventoryType: .shield)
    }
    
    override init(nineum: Nineum) {
        super.init(nineum: nineum)
        elementBoost = calculateElementalModifier(nineum: nineum)
        statBoost = calculateStatModifier(nineum: nineum)
    }
    
    func calculateStatModifier(nineum: Nineum) -> Int {
        var baseModifier = 4
        switch rarity {
        case .common:
            baseModifier = baseModifier + 0
        case .nine:
            baseModifier = baseModifier + 2
        case .uncommon:
            baseModifier = baseModifier + 4
        case .rare:
            baseModifier = baseModifier + 6
        case .epic:
            baseModifier = baseModifier + 8
        case .legendary:
            baseModifier = baseModifier + 11
        case .mythical:
            baseModifier = baseModifier + 14
        }
        
        switch nineum.charge {
        case .positive:
            baseModifier = baseModifier + 1
        case .negative:
            baseModifier = baseModifier + 3
        }
        
        switch nineum.direction {
        case .up:
            baseModifier = baseModifier + 1
        case .down:
            baseModifier = baseModifier + 2
        case .west:
            baseModifier = baseModifier + 3
        case .east:
            baseModifier = baseModifier + 4
        case .north:
            baseModifier = baseModifier + 5
        case .south:
            baseModifier = baseModifier + 6
        }
        
        return baseModifier
    }
    
    func calculateElementalModifier(nineum: Nineum) -> Int {
        var baseModifier = 0
        switch rarity {
        case .common:
            baseModifier = baseModifier + 0
        case .nine:
            baseModifier = baseModifier + 2
        case .uncommon:
            baseModifier = baseModifier + 4
        case .rare:
            baseModifier = baseModifier + 6
        case .epic:
            baseModifier = baseModifier + 8
        case .legendary:
            baseModifier = baseModifier + 11
        case .mythical:
            baseModifier = baseModifier + 14
        }
        
        switch nineum.charge {
        case .positive:
            baseModifier = baseModifier + 0
        case .negative:
            baseModifier = baseModifier + 2
        }
        
        switch nineum.direction {
        case .up:
            baseModifier = baseModifier + 1
        case .down:
            baseModifier = baseModifier + 2
        case .west:
            baseModifier = baseModifier + 3
        case .east:
            baseModifier = baseModifier + 4
        case .north:
            baseModifier = baseModifier + 5
        case .south:
            baseModifier = baseModifier + 6
        }
        
        return baseModifier
    }
}
