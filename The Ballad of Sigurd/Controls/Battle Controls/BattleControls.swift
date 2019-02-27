//
//  BattleControls.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/26/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

enum ControlStates {
    case none
    case sigurd
    case bryn
    case alvis
    case drawing
    case runeDrawn
}

class BattleControls {
    
    let scene: BattleScene
    
    init(scene: BattleScene) {
        self.scene = scene
    }
    
    func touchesBeganHandler(_ touches: Set<UITouch>) {
        
    }
    
    func touchesMovedHandler(_ touches: Set<UITouch>) {
        
    }
    
    func touchesEndedHandler(_ touches: Set<UITouch>) {
        for touch in touches {
            let nodesAtPoint = scene.nodes(at: touch.location(in: scene))
            for node in nodesAtPoint {
                if let nameOfNode = node.name {
                    switch nameOfNode {
                    case CharacterNames.sigurd.rawValue:
                        print("Do Sigurd stuff")
                    case CharacterNames.bryn.rawValue:
                        print("Do Bryn stuff")
                    default:
                        print("Do other stuff here")
                    }
                }
            }
        }
    }
}
