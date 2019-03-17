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
    
    var statColumn: StatColumn = StatColumn(character: AbstractPlayerCharacter(named: .sigurd))
    var equipmentConsole: EquipmentConsole = EquipmentConsole(character: AbstractPlayerCharacter(named: .sigurd))
    var inventorySelector: InventorySelector = InventorySelector(character: AbstractPlayerCharacter(named: .sigurd), inventory: Inventory())
    
    override func didMove(to view: SKView) {
        
        controls = InventoryControls(scene: self)
        
        let backgroundNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        backgroundNode.fillColor = UIColor.PlanetNineColors.darkPrimary
        backgroundNode.lineWidth = 0
        //backgroundNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        backgroundNode.position = CGPoint(x: 0, y: 0)
        self.addChild(backgroundNode)
        
        statColumn = StatColumn(character: AbstractPlayerCharacter(named: .sigurd))
        //statColumn.columnNode.position = CGPoint(x: 158, y: 640)
        statColumn.columnNode.position = CGPoint(x: 55, y: 187.5)
        
        equipmentConsole = EquipmentConsole(character: AbstractPlayerCharacter(named: .sigurd))
        equipmentConsole.backingNode.position = CGPoint(x: 273.5, y: 187.5)
        
        guard let user = UserModel().getUser() else {
            print("Could not find a user")
            return
        }
        print("About to get inventory")
        print(user.nineum.count)
        let inventoryManager = InventoryManager()
        print("Initialized inventoryManager")
        let inventory = inventoryManager.getInventoryForNineumHexStrings(nineumHexStrings: user.nineum)
        print(inventory.weapons)
        inventorySelector = InventorySelector(character: AbstractPlayerCharacter(named: .sigurd), inventory: inventory)
        inventorySelector.backingNode.position = CGPoint(x: 552.5, y: 187.5)
        inventorySelector.scene = self
        
        self.addChild(statColumn.columnNode)
        self.addChild(equipmentConsole.backingNode)
        self.addChild(inventorySelector.backingNode)
        
        view.addSubview(inventorySelector.tableView)
    }
    
    func updateSelectedEquipmentSlot(equipmentSlot: String) {
        equipmentConsole.updateSelectedEquipementSlot(equipmentSlot: equipmentSlot)
    }
    
    func updateInventorySelection(selection: InventorySelections) {
        inventorySelector.updateInventorySelection(selection: selection)
    }
    
    func equipItem(inventoryItem: InventoryItem) {
        equipmentConsole.equipItem(inventoryItem: inventoryItem)
        statColumn.updateStatsWithInventory(inventory: equipmentConsole.equippedInventory)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        controls?.touchesBeganHandler(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        controls?.touchesMovedHandler(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        controls?.touchesEndedHandler(touches)
    }
}
