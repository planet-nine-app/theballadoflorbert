//
//  InventoryControls.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 3/16/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class InventoryControls: AbstractControls {
    
    enum ControlStates {
        case characterSelection
        case equipmentSelection
    }
    
    let scene: InventoryScene
    var controlState: ControlStates = .characterSelection
    
    init(scene: InventoryScene) {
        self.scene = scene
    }
    
    override func touchesBeganHandler(_ touches: Set<UITouch>) {
        print("Touches began")
    }
    
    override func touchesMovedHandler(_ touches: Set<UITouch>) {
        print("touches moved")
    }
    
    override func touchesEndedHandler(_ touches: Set<UITouch>) {
        print("Touches ended")
        let beginningControlState = controlState
        for touch in touches {
            let nodesAtPoint = scene.nodes(at: touch.location(in: scene))
            print(nodesAtPoint.count)
            for node in nodesAtPoint {
                print(node.position)
                print(node.name)
                
                if node.name != nil {
                    if beginningControlState == .characterSelection {
                        switch node.name {
                        case "characterLorbert":
                            print("Sigurd")
                            scene.characterSelected(character: .sigurd)
                            controlState = .equipmentSelection
                        case "characterArtro":
                            print("Bryn")
                            scene.characterSelected(character: .bryn)
                            controlState = .equipmentSelection
                        case "characterI-O":
                            print("Anders")
                            scene.characterSelected(character: .anders)
                            controlState = .equipmentSelection
                        default:
                            print("Default")
                        }
                    } else if beginningControlState == .equipmentSelection {
                        print("Node name is \(node.name)")
                        switch node.name {
                        case "exit":
                            scene.exit()
                        case "characterSelected":
                            scene.selectedCharacterTapped()
                            controlState = .characterSelection
                        case "autoEquip":
                            scene.autoEquipTapped()
                        case "equipment0":
                            scene.updateInventorySelection(selection: .weapon)
                            scene.updateSelectedEquipmentSlot(equipmentSlot: node.name!)
                        case "equipment1":
                            scene.updateInventorySelection(selection: .helm)
                            scene.updateSelectedEquipmentSlot(equipmentSlot: node.name!)
                        case "equipment2":
                            scene.updateInventorySelection(selection: .bodyArmor)
                            scene.updateSelectedEquipmentSlot(equipmentSlot: node.name!)
                        case "equipment3":
                            scene.updateInventorySelection(selection: .bracers)
                            scene.updateSelectedEquipmentSlot(equipmentSlot: node.name!)
                        case "equipment4":
                            scene.updateInventorySelection(selection: .shield)
                            scene.updateSelectedEquipmentSlot(equipmentSlot: node.name!)
                        case "equipment5":
                            scene.updateInventorySelection(selection: .gloves)
                            scene.updateSelectedEquipmentSlot(equipmentSlot: node.name!)
                        case "equipment6":
                            scene.updateInventorySelection(selection: .necklace)
                            scene.updateSelectedEquipmentSlot(equipmentSlot: node.name!)
                        case "equipment7":
                            scene.updateInventorySelection(selection: .boots)
                            scene.updateSelectedEquipmentSlot(equipmentSlot: node.name!)
                        default:
                            print("Found unhandled node name: \(node.name)")
                        }
                    }
                }
            }
        }
    }
}
