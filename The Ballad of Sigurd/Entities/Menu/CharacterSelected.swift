//
//  CharacterSelected.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 3/25/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class CharacterSelected {
    
    var backingNode: SKShapeNode
    var character: AbstractPlayerCharacter
    var nameNode: SKLabelNode
    var levelNode: SKLabelNode
    
    init(character: AbstractPlayerCharacter) {
        self.character = character
        backingNode = SKShapeNode(path: CGPath(roundedRect: CGRect(x: 0, y: 0, width: 170, height: 30), cornerWidth: 15, cornerHeight: 15, transform: nil))
        backingNode.fillColor = UIColor.white
        backingNode.lineWidth = 0
        backingNode.zPosition = 105.0
        backingNode.name = "characterSelected"
        
        let circleNode = SKShapeNode(circleOfRadius: 11)
        circleNode.fillColor = UIColor.PlanetNineColors.secondary
        circleNode.lineWidth = 0
        circleNode.zPosition = 106.0
        circleNode.position = CGPoint(x: 15, y: 15)
        
        let characterName = character.name.rawValue
        nameNode = SKLabelNode(text: "\(characterName)")
        nameNode.fontName = "Orbitron-Bold"
        nameNode.fontColor = UIColor.PlanetNineColors.primary
        nameNode.fontSize = 12
        nameNode.position = CGPoint(x: 54, y: 10)
        nameNode.zPosition = 106.0
        
        let level = character.level
        levelNode = SKLabelNode(text: "Level \(level)")
        levelNode.fontName = "Ubuntu-Medium"
        levelNode.fontColor = UIColor.PlanetNineColors.primary
        levelNode.fontSize = 10
        levelNode.position = CGPoint(x: 111, y: 10)
        levelNode.zPosition = 106.0
        
        let disclaimerNode = SKLabelNode(text: ">")
        disclaimerNode.fontName = "Orbitron-Bold"
        disclaimerNode.fontColor = UIColor.PlanetNineColors.primary
        disclaimerNode.fontSize = 12
        disclaimerNode.position = CGPoint(x: 159, y: 10)
        disclaimerNode.zPosition = 106.0
        
        backingNode.addChild(circleNode)
        backingNode.addChild(nameNode)
        backingNode.addChild(levelNode)
        backingNode.addChild(disclaimerNode)
    }
    
    func updateCharacter(character: AbstractPlayerCharacter) {
        self.character = character
        
        let characterName = character.name.rawValue
        nameNode.text = characterName
        
        let level = character.level
        levelNode.text = "Level \(level)"
    }
}
