//
//  CharacterSelector.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 3/22/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class CharacterSelector {
    
    var backingNode = SKShapeNode()
    
    init() {
        //let backingNode = SKShapeNode(rectOf: CGSize(width: 243, height: 195))
        backingNode = SKShapeNode(path: CGPath(roundedRect: CGRect(x: 0, y: 0, width: 243, height: 195), cornerWidth: 12, cornerHeight: 12, transform: nil))
        backingNode.fillColor = UIColor.white
        backingNode.zPosition = 100.0
        backingNode.position = CGPoint(x: 150, y: 100)
        
        let selectLabelNode = SKLabelNode(text: "Select a character")
        selectLabelNode.fontName = "Ubuntu-Medium"
        selectLabelNode.fontSize = 10
        selectLabelNode.fontColor = UIColor.PlanetNineColors.primary
        selectLabelNode.position = CGPoint(x: 27, y: 181)
        selectLabelNode.horizontalAlignmentMode = .left
        selectLabelNode.zPosition = 101.0
        
        let sigurdNode = createCharacterNode(yPosition: 0)
        let brynNode = createCharacterNode(yPosition: 1)
        let andersNode = createCharacterNode(yPosition: 2)
        
        backingNode.addChild(selectLabelNode)
        backingNode.addChild(sigurdNode)
        backingNode.addChild(brynNode)
        backingNode.addChild(andersNode)
    }
    
    func createCharacterNode(yPosition: Int) -> SKShapeNode {
        let backingNode = SKShapeNode(rectOf: CGSize(width: 243, height: 52))
        var characterName = ""
        switch yPosition {
        case 0:
            characterName = CharacterNames.sigurd.rawValue
        case 1:
            characterName = CharacterNames.bryn.rawValue
        case 2:
            characterName = CharacterNames.anders.rawValue
        default:
            backingNode.fillColor = UIColor.purple
        }
        
        backingNode.position = CGPoint(x: 121, y: 195 - 65 - (52 * yPosition))
        backingNode.zPosition = 101.0
        backingNode.lineWidth = 0
        backingNode.name = "character\(characterName)"
        
        let circleNode = SKShapeNode(circleOfRadius: 20)
        circleNode.fillColor = UIColor.PlanetNineColors.secondary
        circleNode.position = CGPoint(x: -82.5, y: 0)
        circleNode.zPosition = 102.0
        
        let characterLabelNode = SKLabelNode(text: characterName)
        characterLabelNode.fontName = "Orbitron-Bold"
        characterLabelNode.fontSize = 12
        characterLabelNode.fontColor = UIColor.PlanetNineColors.primary
        characterLabelNode.position = CGPoint(x: -49.0, y: 2)
        characterLabelNode.zPosition = 102.0
        characterLabelNode.horizontalAlignmentMode = .left
        
        let levelLabelNode = SKLabelNode(text: "Level 1")
        levelLabelNode.fontName = "Ubuntu-Medium"
        levelLabelNode.fontSize = 10
        levelLabelNode.fontColor = UIColor.PlanetNineColors.primary
        levelLabelNode.position = CGPoint(x: -49.0, y: -12)
        levelLabelNode.zPosition = 102.0
        levelLabelNode.horizontalAlignmentMode = .left
        
        backingNode.addChild(circleNode)
        backingNode.addChild(characterLabelNode)
        backingNode.addChild(levelLabelNode)
        
        return backingNode
    }
}
