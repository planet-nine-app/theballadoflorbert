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
    var playerCharacter: AbstractPlayerCharacter
    let equipmentNodeSize = CGSize(width: 60, height: 90)
    let nineumNodeRadius = 30.0
    let backingNodeSize = CGSize(width: 327, height: 375)
    let backingNode: SKShapeNode
    var equippedInventory = Inventory()
    var currentSelection = "equipment0"
    var equipmentNodes = [String: SKShapeNode]()
    var party: Party?
    
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
        powerNode.position = CGPoint(x: 80, y: 149)
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
        
        let autoEquipNode = SKShapeNode(path: CGPath(roundedRect: CGRect(x: 0, y: 0, width: 118, height: 22), cornerWidth: 11, cornerHeight: 11, transform: nil))
        autoEquipNode.lineWidth = 2
        autoEquipNode.strokeColor = UIColor.PlanetNineColors.primary
        autoEquipNode.position = CGPoint(x: -80, y: -167.5)
        autoEquipNode.zPosition = ZPositions.runeNode.rawValue
        autoEquipNode.name = "autoEquip"
        
        let autoEquipLabel = SKLabelNode(text: "Auto Equip")
        autoEquipLabel.fontName = "Orbitron-Bold"
        autoEquipLabel.fontColor = UIColor.PlanetNineColors.primary
        autoEquipLabel.fontSize = 12
        autoEquipLabel.position = CGPoint(x: 59, y: 8)
        
        autoEquipNode.addChild(autoEquipLabel)
        
        backingNode.addChild(powerNode)
        backingNode.addChild(equipNode)
        backingNode.addChild(useNode)
        backingNode.addChild(autoEquipNode)
        
        for (equipmentKey, equipmentNode) in equipmentNodes {
            print("Adding \(equipmentKey)")
            backingNode.addChild(equipmentNode)
        }
        
        updateSelectedEquipementSlot(equipmentSlot: "equipment0")
    }
    
    func generateEquipmentNodes() {
        var i = 0
        while i < 8 {
            let equipmentNode = SKShapeNode(rectOf: equipmentNodeSize)
            let yPosition = i < 4 ? 7.7 : -113.5
            let xPosition = i < 4 ? (-327 / 2 + (60 * i) + (18 * i) + 30) : (-327 / 2 + (60 * (i - 4)) + (18 * (i - 4)) + 30)
            equipmentNode.position = CGPoint(x: Double(xPosition), y: yPosition)
            equipmentNode.lineWidth = 0
            equipmentNode.strokeColor = UIColor.yellow
            equipmentNode.zPosition = ZPositions.runeNode.rawValue
            equipmentNode.name = "equipment\(i)"
            
            addEmptyEquipmentNodesToEquipmentNode(equipmentNode: equipmentNode)
            
            print(equipmentNode.name!)
            equipmentNodes[equipmentNode.name!] = equipmentNode
            
            i = i + 1
        }
    }
    
    func addEmptyEquipmentNodesToEquipmentNode(equipmentNode: SKShapeNode) {
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
    }
    
    func updateSelectedEquipementSlot(equipmentSlot: String) {
        let currentNode = equipmentNodes[currentSelection]
        currentNode?.lineWidth = 0
        let equipementNode = equipmentNodes[equipmentSlot]
        equipementNode?.lineWidth = 2
        
        currentSelection = equipmentSlot
    }
    
    func equipItem(inventoryItem: InventoryItem) {
        print(playerCharacter.name.rawValue)
        switch inventoryItem.inventoryType {
        case .weapon:
            equippedInventory.weapons = []
            equippedInventory.weapons.append(inventoryItem as! Weapon)
        case .helm:
            equippedInventory.helms = []
            equippedInventory.helms.append(inventoryItem as!
            Helm)
        case .bodyArmor:
            equippedInventory.bodyArmor = []
            equippedInventory.bodyArmor.append(inventoryItem as! BodyArmor)
        case .bracers:
            equippedInventory.bracers = []
            equippedInventory.bracers.append(inventoryItem as! Bracers)
        case .shield:
            equippedInventory.shields = []
            equippedInventory.shields.append(inventoryItem as! Shield)
        case .gloves:
            equippedInventory.gloves = []
            equippedInventory.gloves.append(inventoryItem as! Gloves)
        case .necklace:
            equippedInventory.necklaces = []
            equippedInventory.necklaces.append(inventoryItem as! Necklace)
        case .boots:
            equippedInventory.boots = []
            equippedInventory.boots.append(inventoryItem as! Boots)
        }
        
        print("before")
        print(party!.sigurd.inventory)
        print(party!.bryn.inventory)
        
        playerCharacter.inventory = equippedInventory
        
        print("after")
        print(party!.sigurd.inventory)
        print(party!.bryn.inventory)
        
        updateEquipmentSlots()
    }
    
    func addEquipmentToEquipmentNode(equipmentNode: SKShapeNode, equipment: InventoryItem) {
        let nineumNode: SKSpriteNode?
        switch equipment.nineum!.rarity {
        case .common:
            nineumNode = SKSpriteNode(imageNamed: "Nineum1_Small@3x.png")
        case .nine:
            nineumNode = SKSpriteNode(imageNamed: "Nineum2_Small@3x.png")
        case .uncommon:
            nineumNode = SKSpriteNode(imageNamed: "Nineum3_Small@3x.png")
        case .rare:
            nineumNode = SKSpriteNode(imageNamed: "Nineum4_Small@3x.png")
        case .epic:
            nineumNode = SKSpriteNode(imageNamed: "Nineum5_Small@3x.png")
        case .legendary:
            nineumNode = SKSpriteNode(imageNamed: "Nineum6_Small@3x.png")
        case .mythical:
            nineumNode = SKSpriteNode(imageNamed: "Nineum7_Small@3x.png")
        }
        guard let unwrappedNineumNode = nineumNode else {
            print("Could not make Nineum Node")
            return
        }
        unwrappedNineumNode.position = CGPoint(x: 0, y: 30)
        unwrappedNineumNode.zPosition = ZPositions.rune.rawValue
        unwrappedNineumNode.scale(to: CGSize(width: 60.0, height: 60.0))
        
        let firstLine = SKLabelNode(text: equipment.toString())
        firstLine.fontName = "Orbitron-Bold"
        firstLine.fontSize = 10
        firstLine.fontColor = UIColor.PlanetNineColors.secondary
        firstLine.position = CGPoint(x: 0, y: -12)
        firstLine.zPosition = ZPositions.rune.rawValue
        
        
        let stat = equipment.stat.rawValue
        let boost = equipment.statBoost
        let secondLine = SKLabelNode(text: "\(stat) +\(boost)")
        secondLine.fontName = "Ubuntu-Medium"
        secondLine.fontSize = 8
        secondLine.fontColor = UIColor.white
        secondLine.position = CGPoint(x: 0, y: -26)
        secondLine.zPosition = ZPositions.rune.rawValue
        
        equipmentNode.addChild(unwrappedNineumNode)
        equipmentNode.addChild(firstLine)
        equipmentNode.addChild(secondLine)
    }
    
    func updateEquipmentSlots() {
        if equippedInventory.weapons.count > 0 {
           equipmentNodes["equipment0"]?.removeAllChildren()
            addEquipmentToEquipmentNode(equipmentNode: equipmentNodes["equipment0"]!, equipment: equippedInventory.weapons[0])
        } else {
            equipmentNodes["equipment0"]?.removeAllChildren()
            addEmptyEquipmentNodesToEquipmentNode(equipmentNode: equipmentNodes["equipment0"]!)
        }
        if equippedInventory.helms.count > 0 {
            equipmentNodes["equipment1"]?.removeAllChildren()
            addEquipmentToEquipmentNode(equipmentNode: equipmentNodes["equipment1"]!, equipment: equippedInventory.helms[0])
        } else {
            equipmentNodes["equipment1"]?.removeAllChildren()
            addEmptyEquipmentNodesToEquipmentNode(equipmentNode: equipmentNodes["equipment1"]!)
        }
        if equippedInventory.bodyArmor.count > 0 {
            equipmentNodes["equipment2"]?.removeAllChildren()
            addEquipmentToEquipmentNode(equipmentNode: equipmentNodes["equipment2"]!, equipment: equippedInventory.bodyArmor[0])
        } else {
            equipmentNodes["equipment2"]?.removeAllChildren()
            addEmptyEquipmentNodesToEquipmentNode(equipmentNode: equipmentNodes["equipment2"]!)
        }
        if equippedInventory.bracers.count > 0 {
            equipmentNodes["equipment3"]?.removeAllChildren()
            addEquipmentToEquipmentNode(equipmentNode: equipmentNodes["equipment3"]!, equipment: equippedInventory.bracers[0])
        } else {
            equipmentNodes["equipment3"]?.removeAllChildren()
            addEmptyEquipmentNodesToEquipmentNode(equipmentNode: equipmentNodes["equipment3"]!)
        }
        if equippedInventory.shields.count > 0 {
            equipmentNodes["equipment4"]?.removeAllChildren()
            addEquipmentToEquipmentNode(equipmentNode: equipmentNodes["equipment4"]!, equipment: equippedInventory.shields[0])
        } else {
            equipmentNodes["equipment4"]?.removeAllChildren()
            addEmptyEquipmentNodesToEquipmentNode(equipmentNode: equipmentNodes["equipment4"]!)
        }
        if equippedInventory.gloves.count > 0 {
            equipmentNodes["equipment5"]?.removeAllChildren()
            addEquipmentToEquipmentNode(equipmentNode: equipmentNodes["equipment5"]!, equipment: equippedInventory.gloves[0])
        } else {
            equipmentNodes["equipment5"]?.removeAllChildren()
            addEmptyEquipmentNodesToEquipmentNode(equipmentNode: equipmentNodes["equipment5"]!)
        }
        if equippedInventory.necklaces.count > 0 {
            equipmentNodes["equipment6"]?.removeAllChildren()
            addEquipmentToEquipmentNode(equipmentNode: equipmentNodes["equipment6"]!, equipment: equippedInventory.necklaces[0])
        } else {
            equipmentNodes["equipment6"]?.removeAllChildren()
            addEmptyEquipmentNodesToEquipmentNode(equipmentNode: equipmentNodes["equipment6"]!)
        }
        if equippedInventory.boots.count > 0 {
            equipmentNodes["equipment7"]?.removeAllChildren()
            addEquipmentToEquipmentNode(equipmentNode: equipmentNodes["equipment7"]!, equipment: equippedInventory.boots[0])
        } else {
            equipmentNodes["equipment7"]?.removeAllChildren()
            addEmptyEquipmentNodesToEquipmentNode(equipmentNode: equipmentNodes["equipment7"]!)
        }
        
        print("after update equipment slots")
        print(party!.sigurd.inventory)
        print(party!.bryn.inventory)
    }
    
    func updateCharacter(character: AbstractPlayerCharacter) {
        playerCharacter = character
        equippedInventory = character.inventory
        print(character.name.rawValue)
        print(character.inventory)
        updateEquipmentSlots()
    }
    
    func autoEquip() {
        print("Here is where you auto equip")
        guard let user = UserModel().getUser() else {
            print("Could not find a user")
            return
        }
        print("About to get inventory")
        print(user.nineum.count)
        let inventoryManager = InventoryManager()
        print("Initialized inventoryManager")
        let inventory = inventoryManager.getInventoryForNineumHexStrings(nineumHexStrings: user.nineum)
        var autoEquippedInventory = Inventory()
        autoEquippedInventory.weapons.append(inventory.weapons[0])
        autoEquippedInventory.helms.append(inventory.helms[0])
        autoEquippedInventory.bodyArmor.append(inventory.bodyArmor[0])
        autoEquippedInventory.shields.append(inventory.shields[0])
        autoEquippedInventory.bracers.append(inventory.bracers[0])
        autoEquippedInventory.necklaces.append(inventory.necklaces[0])
        autoEquippedInventory.gloves.append(inventory.gloves[0])
        autoEquippedInventory.boots.append(inventory.boots[0])
        
        equippedInventory = autoEquippedInventory
        playerCharacter.inventory = autoEquippedInventory
        updateEquipmentSlots()
    }
}
