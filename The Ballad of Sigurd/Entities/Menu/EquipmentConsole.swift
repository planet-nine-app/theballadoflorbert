//
//  EquipmentConsole.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 3/15/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class EquipmentConsole {
    let playerCharacter: AbstractPlayerCharacter
    let equipmentNodeSize = CGSize(width: 60, height: 90)
    let nineumNodeRadius = 30.0
    let backingNodeSize = CGSize(width: 327, height: 375)
    let backingNode: SKShapeNode
    var equipmentNodes = [String: SKShapeNode]()
    
    init(character: AbstractPlayerCharacter) {
        playerCharacter = character
        backingNode = SKShapeNode(rectOf: backingNodeSize)
        //backingNode.fillColor = UIColor.blue
        backingNode.lineWidth = 0
        guard let user = UserModel().getUser() else {
            print("Could not find user")
            return
        }
        let currentPower = user.currentPower
        let powerNode = SKLabelNode(text: "\(currentPower) Power")
        powerNode.fontName = "Orbitron-Bold"
        powerNode.fontSize = 17
        powerNode.fontColor = UIColor.PlanetNineColors.primary
        powerNode.position = CGPoint(x: 0, y: 149)
        powerNode.zPosition = ZPositions.runeNode.rawValue
        
        let equipNode = SKLabelNode(text: "Equip")
        equipNode.fontName = "Orbitron-Bold"
        equipNode.fontSize = 12
        equipNode.fontColor = UIColor.white
        equipNode.horizontalAlignmentMode = .left
        equipNode.position = CGPoint(x: -163, y: 108)
        equipNode.zPosition = ZPositions.runeNode.rawValue
        
        let useNode = SKLabelNode(text: "Use your inventory to improve your stats and win the fight")
        useNode.fontName = "Ubuntu-Medium"
        useNode.fontSize = 10
        useNode.fontColor = UIColor.white
        useNode.horizontalAlignmentMode = .left
        useNode.position = CGPoint(x: -163, y: 94)
        useNode.zPosition = ZPositions.runeNode.rawValue
        
        generateEquipmentNodes()
        
        backingNode.addChild(powerNode)
        backingNode.addChild(equipNode)
        backingNode.addChild(useNode)
        
        for (equipmentKey, equipmentNode) in equipmentNodes {
            print("Adding \(equipmentKey)")
            backingNode.addChild(equipmentNode)
        }
    }
    
    func generateEquipmentNodes() {
        var i = 0
        while i < 8 {
            let equipmentNode = SKShapeNode(rectOf: equipmentNodeSize)
            let yPosition = i < 4 ? 7.5 : -113.5
            let xPosition = i < 4 ? (-327 / 2 + (60 * i) + (18 * i) + 30) : (-327 / 2 + (60 * (i - 4)) + (18 * (i - 4)) + 30)
            equipmentNode.position = CGPoint(x: Double(xPosition), y: yPosition)
            equipmentNode.lineWidth = 0
            equipmentNode.zPosition = ZPositions.runeNode.rawValue
            equipmentNode.name = "equipment\(i)"
            
            let nineumNode = SKShapeNode(circleOfRadius: CGFloat(nineumNodeRadius))
            nineumNode.fillColor = UIColor.PlanetNineColors.blankInventory
            nineumNode.lineWidth = 0
            nineumNode.position = CGPoint(x: 0, y: 30)
            nineumNode.zPosition = ZPositions.rune.rawValue
            
            let firstLine = SKLabelNode(text: "Add from")
            firstLine.fontName = "Ubuntu-Medium"
            firstLine.fontSize = 8
            firstLine.fontColor = UIColor.PlanetNineColors.blankInventory
            firstLine.position = CGPoint(x: 0, y: -12)
            firstLine.zPosition = ZPositions.rune.rawValue
            
            let secondLine = SKLabelNode(text: "Inventory")
            secondLine.fontName = "Ubuntu-Medium"
            secondLine.fontSize = 8
            secondLine.fontColor = UIColor.PlanetNineColors.blankInventory
            secondLine.position = CGPoint(x: 0, y: -26)
            secondLine.zPosition = ZPositions.rune.rawValue
            
            equipmentNode.addChild(nineumNode)
            equipmentNode.addChild(firstLine)
            equipmentNode.addChild(secondLine)
            
            equipmentNodes[equipmentNode.name!] = equipmentNode
            
            i = i + 1
        }
    }
}
