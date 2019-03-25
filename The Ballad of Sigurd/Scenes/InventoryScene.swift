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
    var characterSelected: CharacterSelected = CharacterSelected(character: AbstractPlayerCharacter(named: .sigurd))
    var inventorySelector: InventorySelector = InventorySelector(character: AbstractPlayerCharacter(named: .sigurd), inventory: Inventory())
    var exitButton: ExitButton = ExitButton()
    var blurringView = UIView()
    var characterSelector = CharacterSelector()
    var opacityNode = SKShapeNode()
    
    override func didMove(to view: SKView) {
        
        controls = InventoryControls(scene: self)
        
        guard let sigurd = party?.sigurd else {
            print("Party not set")
            return
        }
        
        let backgroundNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        backgroundNode.fillColor = UIColor.PlanetNineColors.darkPrimary
        backgroundNode.lineWidth = 0
        //backgroundNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        backgroundNode.position = CGPoint(x: 0, y: 0)
        self.addChild(backgroundNode)
        
        statColumn = StatColumn(character: sigurd)
        //statColumn.columnNode.position = CGPoint(x: 158, y: 640)
        statColumn.columnNode.position = CGPoint(x: 55, y: 187.5)
        
        exitButton.exitNode.position = CGPoint(x: 32, y: 345)
        
        equipmentConsole = EquipmentConsole(character: sigurd)
        equipmentConsole.party = party!
        equipmentConsole.backingNode.position = CGPoint(x: 273.5, y: 187.5)
        
        characterSelected.backingNode.position = CGPoint(x: 80, y: 330)
        
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
        inventorySelector = InventorySelector(character: sigurd, inventory: inventory)
        inventorySelector.backingNode.position = CGPoint(x: 552.5, y: 187.5)
        inventorySelector.scene = self
        
        /*blurringView = UIView(frame: view.frame)
        blurringView.backgroundColor = UIColor.PlanetNineColors.primary
        blurringView.layer.opacity = 0.7*/
        
        self.addChild(statColumn.columnNode)
        self.addChild(exitButton.exitNode)
        self.addChild(equipmentConsole.backingNode)
        self.addChild(characterSelected.backingNode)
        self.addChild(inventorySelector.backingNode)
        
        inventorySelector.tableView.layer.opacity = 0.7
        characterSelected.backingNode.alpha = 0.7
        view.addSubview(inventorySelector.tableView)
        
        //view.addSubview(blurringView)
        
        opacityNode = SKShapeNode(rectOf: CGSize(width: 667, height: 375))
        opacityNode.fillColor = UIColor.PlanetNineColors.primary
        opacityNode.alpha = 0.7
        opacityNode.position = CGPoint(x: 333.5, y: 187.5)
        opacityNode.zPosition = 99.0
        
        self.addChild(opacityNode)
        self.addChild(characterSelector.backingNode)
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
    
    func characterSelected(character: CharacterNames) {
        opacityNode.removeFromParent()
        inventorySelector.tableView.layer.opacity = 1.0
        characterSelected.backingNode.alpha = 1.0
        characterSelector.backingNode.removeFromParent()
        
        var playerCharacter: AbstractPlayerCharacter
        switch character {
        case .sigurd:
            playerCharacter = party!.sigurd
        case .bryn:
            playerCharacter = party!.bryn
        case .anders:
            playerCharacter = party!.anders
        }
        
        print("sigurd inventory: \(party!.sigurd.inventory)")
        print("bryn inventory: \(party!.bryn.inventory)")
        print("anders inventory: \(party!.anders.inventory)")
        
        characterSelected.updateCharacter(character: playerCharacter)
        statColumn.updateCharacter(character: playerCharacter)
        equipmentConsole.updateCharacter(character: playerCharacter)
    }
    
    func selectedCharacterTapped() {
        
        print("tapped sigurd inventory: \(party!.sigurd.inventory)")
        print("tapped bryn inventory: \(party!.bryn.inventory)")
        print("tapped anders inventory: \(party!.anders.inventory)")
        self.addChild(opacityNode)
        inventorySelector.tableView.layer.opacity = 0.7
        characterSelected.backingNode.alpha = 0.7
        self.addChild(characterSelector.backingNode)
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
