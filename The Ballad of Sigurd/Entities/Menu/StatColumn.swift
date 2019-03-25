//
//  StatColumn.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 3/5/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

/*class StatColumn {
    let playerCharacter: AbstractPlayerCharacter
    let subNodeSize = CGSize(width: 317, height: 126)
    let columnNode: SKShapeNode
    
    init(character: AbstractPlayerCharacter) {
        playerCharacter = character
        
        columnNode = SKShapeNode(rectOf: CGSize(width: 317, height: 1280))
        columnNode.fillColor = UIColor.blue
        
        let levelNode = SKShapeNode(rectOf: subNodeSize)
        addLevelToNode(node: levelNode)
        levelNode.position = CGPoint(x: 0, y: 540)
        levelNode.zPosition = ZPositions.runeNode.rawValue
        
        let strengthNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .strength, node: strengthNode)
        strengthNode.position = CGPoint(x: 0, y: 398)
        strengthNode.zPosition = ZPositions.runeNode.rawValue
        
        let vitalityNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .vitality, node: vitalityNode)
        vitalityNode.position = CGPoint(x: 0, y: 272)
        vitalityNode.zPosition = ZPositions.runeNode.rawValue
        
        let agilityNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .agility, node: agilityNode)
        agilityNode.position = CGPoint(x: 0, y: 146)
        agilityNode.zPosition = ZPositions.runeNode.rawValue
        
        let dexterityNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .dexterity, node: dexterityNode)
        dexterityNode.position = CGPoint(x: 0, y: 20)
        dexterityNode.zPosition = ZPositions.runeNode.rawValue
        
        let wisdomNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .wisdom, node: wisdomNode)
        wisdomNode.position = CGPoint(x: 0, y: -106)
        wisdomNode.zPosition = ZPositions.runeNode.rawValue
        
        let auraNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .aura, node: auraNode)
        auraNode.position = CGPoint(x: 0, y: -232)
        auraNode.zPosition = ZPositions.runeNode.rawValue
        
        let perceptionNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .perception, node: perceptionNode)
        perceptionNode.position = CGPoint(x: 0, y: -358)
        perceptionNode.zPosition = ZPositions.runeNode.rawValue
        
        let luckNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .luck, node: luckNode)
        luckNode.position = CGPoint(x: 0, y: -484)
        luckNode.zPosition = ZPositions.runeNode.rawValue
        
        columnNode.addChild(levelNode)
        columnNode.addChild(strengthNode)
        columnNode.addChild(vitalityNode)
        columnNode.addChild(agilityNode)
        columnNode.addChild(dexterityNode)
        columnNode.addChild(wisdomNode)
        columnNode.addChild(auraNode)
        columnNode.addChild(perceptionNode)
        columnNode.addChild(luckNode)
    }
    
    func addLevelToNode(node: SKShapeNode) {
        let levelString = "Level \(playerCharacter.level)"
        let levelNode = SKLabelNode(text: levelString)
        levelNode.zPosition = ZPositions.entity.rawValue
        node.addChild(levelNode)
    }
    
    func addStatToNode(stat: Stats, node: SKShapeNode) {
        var statAbbr: String
        var statAmount: String
        switch stat {
        case .strength:
            statAbbr = "Strength"
            statAmount = "\(playerCharacter.strength)"
        case .vitality:
            statAbbr = "Vitality"
            statAmount = "\(playerCharacter.vitality)"
        case .agility:
            statAbbr = "Agility"
            statAmount = "\(playerCharacter.agility)"
        case .dexterity:
            statAbbr = "Dexterity"
            statAmount = "\(playerCharacter.dexterity)"
        case .wisdom:
            statAbbr = "Wisdom"
            statAmount = "\(playerCharacter.wisdom)"
        case .aura:
            statAbbr = "Aura"
            statAmount = "\(playerCharacter.aura)"
        case .perception:
            statAbbr = "Perception"
            statAmount = "\(playerCharacter.perception)"
        case .luck:
            statAbbr = "Luck"
            statAmount = "\(playerCharacter.luck)"
        }
        
        let statNode = SKLabelNode(text: statAmount)
        statNode.position = CGPoint(x: -106, y: 42.6)
        statNode.zPosition = ZPositions.entity.rawValue
        statNode.horizontalAlignmentMode = .left
        let abbreviationNode = SKLabelNode(text: statAbbr)
        abbreviationNode.position = CGPoint(x: -106, y: 5.4)
        abbreviationNode.zPosition = ZPositions.entity.rawValue
        abbreviationNode.horizontalAlignmentMode = .left
        
        node.addChild(statNode)
        node.addChild(abbreviationNode)
    }
}*/

class StatColumn {
    var playerCharacter: AbstractPlayerCharacter
    let subNodeSize = CGSize(width: 110, height: 37)
    let columnNode: SKShapeNode
    var modifiedStats: [Stats: Int]
    
    init(character: AbstractPlayerCharacter) {
        playerCharacter = character
        
        modifiedStats = [Stats: Int]()
        modifiedStats[.strength] = playerCharacter.strength
        modifiedStats[.agility] = playerCharacter.agility
        modifiedStats[.dexterity] = playerCharacter.dexterity
        modifiedStats[.vitality] = playerCharacter.vitality
        modifiedStats[.wisdom] = playerCharacter.wisdom
        modifiedStats[.aura] = playerCharacter.aura
        modifiedStats[.perception] = playerCharacter.perception
        modifiedStats[.luck] = playerCharacter.luck
        
        columnNode = SKShapeNode(rectOf: CGSize(width: 110, height: 375))
        //columnNode.fillColor = UIColor.blue
        columnNode.lineWidth = 0
        
        //addLevelNode()
        
        addStatNodes()
        
    }
    
    func addLevelNode() {
        let levelNode = SKShapeNode(rectOf: subNodeSize)
        addLevelToNode(node: levelNode)
        levelNode.position = CGPoint(x: 0, y: 149)
        levelNode.zPosition = ZPositions.runeNode.rawValue
        levelNode.lineWidth = 0
        
        columnNode.addChild(levelNode)
    }
    
    func addStatNodes() {
        
        let strengthNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .strength, node: strengthNode)
        strengthNode.position = CGPoint(x: 0, y: 100)
        strengthNode.zPosition = ZPositions.runeNode.rawValue
        strengthNode.lineWidth = 0
        
        let vitalityNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .vitality, node: vitalityNode)
        vitalityNode.position = CGPoint(x: 0, y: 63)
        vitalityNode.zPosition = ZPositions.runeNode.rawValue
        vitalityNode.lineWidth = 0
        
        let agilityNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .agility, node: agilityNode)
        agilityNode.position = CGPoint(x: 0, y: 26)
        agilityNode.zPosition = ZPositions.runeNode.rawValue
        agilityNode.lineWidth = 0
        
        let dexterityNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .dexterity, node: dexterityNode)
        dexterityNode.position = CGPoint(x: 0, y: -10)
        dexterityNode.zPosition = ZPositions.runeNode.rawValue
        dexterityNode.lineWidth = 0
        
        let wisdomNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .wisdom, node: wisdomNode)
        wisdomNode.position = CGPoint(x: 0, y: -48)
        wisdomNode.zPosition = ZPositions.runeNode.rawValue
        wisdomNode.lineWidth = 0
        
        let auraNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .aura, node: auraNode)
        auraNode.position = CGPoint(x: 0, y: -84)
        auraNode.zPosition = ZPositions.runeNode.rawValue
        auraNode.lineWidth = 0
        
        let perceptionNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .perception, node: perceptionNode)
        perceptionNode.position = CGPoint(x: 0, y: -121)
        perceptionNode.zPosition = ZPositions.runeNode.rawValue
        perceptionNode.lineWidth = 0
        
        let luckNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .luck, node: luckNode)
        luckNode.position = CGPoint(x: 0, y: -159)
        luckNode.zPosition = ZPositions.runeNode.rawValue
        luckNode.lineWidth = 0
        
        
        columnNode.addChild(strengthNode)
        columnNode.addChild(vitalityNode)
        columnNode.addChild(agilityNode)
        columnNode.addChild(dexterityNode)
        columnNode.addChild(wisdomNode)
        columnNode.addChild(auraNode)
        columnNode.addChild(perceptionNode)
        columnNode.addChild(luckNode)
    }
    
    func addLevelToNode(node: SKShapeNode) {
        let levelString = "Level \(playerCharacter.level)"
        let levelNode = SKLabelNode(text: levelString)
        levelNode.fontName = "Orbitron-Bold"
        levelNode.fontColor = UIColor.PlanetNineColors.primary
        levelNode.fontSize = 17
        levelNode.zPosition = ZPositions.entity.rawValue
        node.addChild(levelNode)
    }
    
    func addStatToNode(stat: Stats, node: SKShapeNode) {
        var statAbbr: String
        var statAmount: String
        switch stat {
        case .strength:
            statAbbr = "Strength"
            statAmount = "\(modifiedStats[.strength]!)"
        case .vitality:
            statAbbr = "Vitality"
            statAmount = "\(modifiedStats[.vitality]!)"
        case .agility:
            statAbbr = "Agility"
            statAmount = "\(modifiedStats[.agility]!)"
        case .dexterity:
            statAbbr = "Dexterity"
            statAmount = "\(modifiedStats[.dexterity]!)"
        case .wisdom:
            statAbbr = "Wisdom"
            statAmount = "\(modifiedStats[.wisdom]!)"
        case .aura:
            statAbbr = "Aura"
            statAmount = "\(modifiedStats[.aura]!)"
        case .perception:
            statAbbr = "Perception"
            statAmount = "\(modifiedStats[.perception]!)"
        case .luck:
            statAbbr = "Luck"
            statAmount = "\(modifiedStats[.luck]!)"
        }
        
        let statNode = SKLabelNode(text: statAmount)
        statNode.position = CGPoint(x: -37, y: 8)
        statNode.zPosition = ZPositions.entity.rawValue
        statNode.horizontalAlignmentMode = .left
        statNode.fontName = "Orbitron-Bold"
        statNode.fontColor = UIColor.PlanetNineColors.secondary
        statNode.fontSize = 12
        let abbreviationNode = SKLabelNode(text: statAbbr)
        abbreviationNode.position = CGPoint(x: -37, y: -5)
        abbreviationNode.zPosition = ZPositions.entity.rawValue
        abbreviationNode.horizontalAlignmentMode = .left
        abbreviationNode.fontName = "Ubuntu-Medium"
        abbreviationNode.fontColor = UIColor.white
        abbreviationNode.fontSize = 10
        
        node.addChild(statNode)
        node.addChild(abbreviationNode)
    }
    
    func updateStatsWithInventory(inventory: Inventory) {
        modifiedStats[.strength] = playerCharacter.strength
        modifiedStats[.agility] = playerCharacter.agility
        modifiedStats[.dexterity] = playerCharacter.dexterity
        modifiedStats[.vitality] = playerCharacter.vitality
        modifiedStats[.wisdom] = playerCharacter.wisdom
        modifiedStats[.aura] = playerCharacter.aura
        modifiedStats[.perception] = playerCharacter.perception
        modifiedStats[.luck] = playerCharacter.luck
        if inventory.weapons.count > 0 {
            let stat = inventory.weapons[0].stat
            let boost = inventory.weapons[0].statBoost
            modifiedStats[stat] = modifiedStats[stat]! + boost
        }
        if inventory.helms.count > 0 {
            let stat = inventory.helms[0].stat
            let boost = inventory.helms[0].statBoost
            modifiedStats[stat] = modifiedStats[stat]! + boost
        }
        if inventory.bodyArmor.count > 0 {
            let stat = inventory.bodyArmor[0].stat
            let boost = inventory.bodyArmor[0].statBoost
            modifiedStats[stat] = modifiedStats[stat]! + boost
        }
        if inventory.bracers.count > 0 {
            let stat = inventory.bracers[0].stat
            let boost = inventory.bracers[0].statBoost
            modifiedStats[stat] = modifiedStats[stat]! + boost
        }
        if inventory.shields.count > 0 {
            let stat = inventory.shields[0].stat
            let boost = inventory.shields[0].statBoost
            modifiedStats[stat] = modifiedStats[stat]! + boost
        }
        if inventory.gloves.count > 0 {
            let stat = inventory.gloves[0].stat
            let boost = inventory.gloves[0].statBoost
            modifiedStats[stat] = modifiedStats[stat]! + boost
        }
        if inventory.necklaces.count > 0 {
            let stat = inventory.necklaces[0].stat
            let boost = inventory.necklaces[0].statBoost
            modifiedStats[stat] = modifiedStats[stat]! + boost
        }
        if inventory.boots.count > 0 {
            let stat = inventory.boots[0].stat
            let boost = inventory.boots[0].statBoost
            modifiedStats[stat] = modifiedStats[stat]! + boost
        }
        
        playerCharacter.inventory = inventory
        
        columnNode.removeAllChildren()
        //addLevelNode()
        addStatNodes()
    }
    
    func updateCharacter(character: AbstractPlayerCharacter) {
        playerCharacter = character
        updateStatsWithInventory(inventory: character.inventory)
    }
}
