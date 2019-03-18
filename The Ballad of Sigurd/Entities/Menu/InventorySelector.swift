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
    let inventory: Inventory
    var scene: InventoryScene?
    var currentSelection: InventorySelections = .weapon
    
    
    init(character: AbstractPlayerCharacter, inventory: Inventory) {
        
        self.inventory = inventory
        
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
        guard let _ = UserModel().getUser() else {
            return 0
        }
        switch currentSelection {
        case .weapon:
            return inventory.weapons.count
        case .helm:
            return inventory.helms.count
        case .bodyArmor:
            return inventory.bodyArmor.count
        case .bracers:
            return inventory.bracers.count
        case .shield:
            return inventory.shields.count
        case .gloves:
            return inventory.gloves.count
        case .necklace:
            return inventory.necklaces.count
        case .boots:
            return inventory.boots.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inventorySelectorTableViewCell") as! InventorySelectorTableViewCell
        switch currentSelection {
        case .weapon:
            cell.setInventoryItemForCell(inventoryItem: inventory.weapons[indexPath[1]])
        case .helm:
            cell.setInventoryItemForCell(inventoryItem: inventory.helms[indexPath[1]])
        case .bodyArmor:
            cell.setInventoryItemForCell(inventoryItem: inventory.bodyArmor[indexPath[1]])
        case .bracers:
            cell.setInventoryItemForCell(inventoryItem: inventory.bracers[indexPath[1]])
        case .shield:
            cell.setInventoryItemForCell(inventoryItem: inventory.shields[indexPath[1]])
        case .gloves:
            cell.setInventoryItemForCell(inventoryItem: inventory.gloves[indexPath[1]])
        case .necklace:
            cell.setInventoryItemForCell(inventoryItem: inventory.necklaces[indexPath[1]])
        case .boots:
            cell.setInventoryItemForCell(inventoryItem: inventory.boots[indexPath[1]])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let inventoryScene = scene else {
            print("You need to set the scene for Inventory Selector")
            return
        }
        switch currentSelection {
        case .weapon:
            inventoryScene.equipItem(inventoryItem: inventory.weapons[indexPath[1]])
        case .helm:
            inventoryScene.equipItem(inventoryItem: inventory.helms[indexPath[1]])
        case .bodyArmor:
            inventoryScene.equipItem(inventoryItem: inventory.bodyArmor[indexPath[1]])
        case .bracers:
            inventoryScene.equipItem(inventoryItem: inventory.bracers[indexPath[1]])
        case .shield:
            inventoryScene.equipItem(inventoryItem: inventory.shields[indexPath[1]])
        case .gloves:
            inventoryScene.equipItem(inventoryItem: inventory.gloves[indexPath[1]])
        case .necklace:
            inventoryScene.equipItem(inventoryItem: inventory.necklaces[indexPath[1]])
        case .boots:
            inventoryScene.equipItem(inventoryItem: inventory.boots[indexPath[1]])
        }
    }
    
    func updateInventorySelection(selection: InventorySelections) {
        currentSelection = selection
        tableView.reloadData()
    }
}
