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
import PlanetNineGateway

class InventorySelector: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    
    
    let playerCharacter: AbstractPlayerCharacter
    let backingNodeSize = CGSize(width: 229, height: 375)
    let backingNode: SKShapeNode
    let tableView = UITableView()
    var nineum = [String]()
    
    init(character: AbstractPlayerCharacter) {
        
        playerCharacter = character
        backingNode = SKShapeNode(rectOf: backingNodeSize)
        backingNode.fillColor = UIColor.PlanetNineColors.closePrimary
        backingNode.lineWidth = 0
        
        super.init()
        
        let inventoryNode = SKLabelNode(text: "Inventory")
        inventoryNode.fontName = "Orbitron-Bold"
        inventoryNode.fontSize = 12
        inventoryNode.fontColor = UIColor.PlanetNineColors.secondary
        inventoryNode.position = CGPoint(x: -96.5, y: 153)
        inventoryNode.zPosition = ZPositions.runeNode.rawValue
        inventoryNode.horizontalAlignmentMode = .left
        
        let selectNode = SKLabelNode(text: "Select from your inventory to equip")
        selectNode.fontName = "Ubuntu-Medium"
        selectNode.fontSize = 10
        selectNode.fontColor = UIColor.white
        selectNode.position = CGPoint(x: -96.5, y: 142)
        selectNode.zPosition = ZPositions.runeNode.rawValue
        selectNode.horizontalAlignmentMode = .left
        
        tableView.frame = CGRect(x: 510, y: 73, width: 229, height: 302)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(InventorySelectorTableViewCell.self, forCellReuseIdentifier: "inventorySelectorTableViewCell")
        tableView.rowHeight = 54
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = UIColor.PlanetNineColors.closePrimary
        
        backingNode.addChild(inventoryNode)
        backingNode.addChild(selectNode)
        
        guard let user = UserModel().getUser() else {
            return
        }
        nineum = user.nineum
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let user = UserModel().getUser() else {
            return 0
        }
        print(user.nineum.count)
        print(section)
        return user.nineum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "inventorySelectorTableViewCell") as! InventorySelectorTableViewCell
        cell.setNineumForCell(nineum: NineumModel().getNineumFromHexString(hexString: nineum[indexPath[1]]))
        return cell
    }
    
}
