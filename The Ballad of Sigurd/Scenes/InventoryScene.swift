//
//  InventoryScene.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/26/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class InventoryScene: AbstractScene {
    
    override func didMove(to view: SKView) {
        let backgroundNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        backgroundNode.fillColor = UIColor.PlanetNineColors.primary
        //backgroundNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        backgroundNode.position = CGPoint(x: 0, y: 0)
        self.addChild(backgroundNode)
        
        let statColumn = StatColumn(character: AbstractPlayerCharacter(named: .sigurd))
        statColumn.columnNode.position = CGPoint(x: 200, y: 450)
        self.addChild(statColumn.columnNode)
    }
}
