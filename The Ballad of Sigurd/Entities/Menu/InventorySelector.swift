//
//  InventorySelector.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 3/15/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class InventorySelector: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    
    
    let playerCharacter: AbstractPlayerCharacter
    let backingNodeSize = CGSize(width: 229, height: 375)
    let backingNode: SKShapeNode
    let tableView = UITableView()
    
    init(character: AbstractPlayerCharacter) {
        playerCharacter = character
        backingNode = SKShapeNode(rectOf: backingNodeSize)
        
        let inventoryNode = SKLabelNode(text: "Inventory")
        inventoryNode.fontName = "Orbitron-Bold"
        inventoryNode.fontSize = 12
        inventoryNode.fontColor = UIColor.PlanetNineColors.secondary
        inventoryNode.position = CGPoint(x: -132.5, y: 149)
        inventoryNode.zPosition = ZPositions.runeNode.rawValue
        inventoryNode.horizontalAlignmentMode = .left
        
        let selectNode = SKLabelNode(text: "Select from your inventory to equip")
        selectNode.fontName = "Ubuntu-Medium"
        selectNode.fontSize = 10
        selectNode.fontColor = UIColor.white
        selectNode.position = CGPoint(x: -132.5, y: 138)
        selectNode.zPosition = ZPositions.runeNode.rawValue
        selectNode.horizontalAlignmentMode = .left
        
        tableView.frame = CGRect(x: 438, y: 73, width: 229, height: 302)
        
        backingNode.addChild(inventoryNode)
        backingNode.addChild(selectNode)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
