//
//  StatColumn.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 3/5/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class StatColumn {
    let playerCharacter: AbstractPlayerCharacter
    let subNodeSize = CGSize(width: 290, height: 90)
    let columnNode: SKShapeNode
    
    init(character: AbstractPlayerCharacter) {
        playerCharacter = character
        
        columnNode = SKShapeNode(rectOf: CGSize(width: 300, height: 900))
        
        let levelNode = SKShapeNode(rectOf: subNodeSize)
        addLevelToNode(node: levelNode)
        levelNode.position = CGPoint(x: 0, y: 400)
        levelNode.zPosition = ZPositions.runeNode.rawValue
        
        let strengthNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .strength, node: strengthNode)
        strengthNode.position = CGPoint(x: 0, y: 300)
        strengthNode.zPosition = ZPositions.runeNode.rawValue
        
        let vitalityNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .vitality, node: vitalityNode)
        vitalityNode.position = CGPoint(x: 0, y: 200)
        vitalityNode.zPosition = ZPositions.runeNode.rawValue
        
        let agilityNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .agility, node: agilityNode)
        agilityNode.position = CGPoint(x: 0, y: 100)
        agilityNode.zPosition = ZPositions.runeNode.rawValue
        
        let dexterityNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .dexterity, node: dexterityNode)
        dexterityNode.position = CGPoint(x: 0, y: 0)
        dexterityNode.zPosition = ZPositions.runeNode.rawValue
        
        let wisdomNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .wisdom, node: wisdomNode)
        wisdomNode.position = CGPoint(x: 0, y: -100)
        wisdomNode.zPosition = ZPositions.runeNode.rawValue
        
        let auraNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .aura, node: auraNode)
        auraNode.position = CGPoint(x: 0, y: -200)
        auraNode.zPosition = ZPositions.runeNode.rawValue
        
        let perceptionNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .perception, node: perceptionNode)
        perceptionNode.position = CGPoint(x: 0, y: -300)
        perceptionNode.zPosition = ZPositions.runeNode.rawValue
        
        let luckNode = SKShapeNode(rectOf: subNodeSize)
        addStatToNode(stat: .luck, node: luckNode)
        luckNode.position = CGPoint(x: 0, y: -400)
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
            statAbbr = "STR"
            statAmount = "\(playerCharacter.strength)"
        case .vitality:
            statAbbr = "VIT"
            statAmount = "\(playerCharacter.vitality)"
        case .agility:
            statAbbr = "AGI"
            statAmount = "\(playerCharacter.agility)"
        case .dexterity:
            statAbbr = "DEX"
            statAmount = "\(playerCharacter.dexterity)"
        case .wisdom:
            statAbbr = "WIS"
            statAmount = "\(playerCharacter.wisdom)"
        case .aura:
            statAbbr = "AUR"
            statAmount = "\(playerCharacter.aura)"
        case .perception:
            statAbbr = "PER"
            statAmount = "\(playerCharacter.perception)"
        case .luck:
            statAbbr = "LUK"
            statAmount = "\(playerCharacter.luck)"
        }
        
        let abbreviationNode = SKLabelNode(text: statAbbr)
        abbreviationNode.position = CGPoint(x: -70, y: 0)
        abbreviationNode.zPosition = ZPositions.entity.rawValue
        let statNode = SKLabelNode(text: statAmount)
        statNode.position = CGPoint(x: 70, y: 0)
        statNode.zPosition = ZPositions.entity.rawValue
        node.addChild(abbreviationNode)
        node.addChild(statNode)
    }
}
