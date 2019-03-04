//
//  TutorialControls.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 3/1/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import UIKit

class TutorialControls: AbstractControls {
    enum ControlStates {
        case none
        case tapSigurd
        case slashEnemy
        case tapBryn
        case tapEnemy
        case drawIsa
        case runeDrawn
    }
    
    let scene: TutorialScene
    let runeNodeName = "RuneNode"
    var controlState: ControlStates = .none
    var sigurdTouchManager = SigurdTouchManager()
    var drawingManager = DrawingManager()
    
    init(scene: TutorialScene) {
        self.scene = scene
    }
    
    override func touchesBeganHandler(_ touches: Set<UITouch>) {
        print("Touch began")
        guard let touch = touches.first else {
            return
        }
        
        if controlState == .slashEnemy {
            sigurdTouchManager.touchArray.append(touch.location(in: scene))
            assessNodesForCurrentEnemy(touch)
        }
        if controlState == .drawIsa {
            let nodesAtPoint = scene.nodes(at: touch.location(in: scene))
            for node in nodesAtPoint {
                if node.name == runeNodeName {
                    drawingManager.startNewTouchArray(location: touch.location(in: scene))
                    scene.addRuneDrawingEmitterNode(touch.location(in: scene))
                }
            }
        }
        if controlState == .runeDrawn {
            scene.moveRuneToPoint(touch.location(in: scene))
        }
    }
    
    override func touchesMovedHandler(_ touches: Set<UITouch>) {
        guard let touch = touches.first else {
            return
        }
        if controlState == .slashEnemy {
            sigurdTouchManager.touchArray.append(touch.location(in: scene))
            assessNodesForCurrentEnemy(touch)
        }
        
        if controlState == .drawIsa {
            drawingManager.addLocationToTouchManager(location: touch.location(in: scene))
            scene.addRuneDrawingEmitterNode(touch.location(in: scene))
        }
        
        if controlState == .runeDrawn {
            scene.moveRuneToPoint(touch.location(in: scene))
        }
    }
    
    override func touchesEndedHandler(_ touches: Set<UITouch>) {
        for touch in touches {
            if controlState == .slashEnemy {
                if sigurdTouchManager.currentEnemy != nil {
                    scene.enemySlashed(enemy: .enemy1)
                    scene.moveToSelectBrynTutorial()
                    controlState = .tapBryn
                    sigurdTouchManager.touchArray = [CGPoint]()
                } else {
                    print("What should happen here?")
                }
            }
            let nodesAtPoint = scene.nodes(at: touch.location(in: scene))
            for node in nodesAtPoint {
                if node.name == "Background" {
                    continue
                }
                switch controlState {
                case .none:
                    if node.name == CharacterNames.sigurd.rawValue {
                        scene.characterTapped(character: .sigurd)
                        scene.moveToSigurdSlashTutorial()
                        controlState = .slashEnemy
                    }
                case .tapSigurd:
                    if node.name == CharacterNames.sigurd.rawValue {
                        scene.characterTapped(character: .sigurd)
                        scene.moveToSigurdSlashTutorial()
                        controlState = .slashEnemy
                    }
                case .slashEnemy:
                    if node.name == EnemyNames.enemy1.rawValue {
                        scene.enemySlashed(enemy: .enemy1)
                        scene.moveToSelectBrynTutorial()
                        controlState = .tapBryn
                        sigurdTouchManager.touchArray = [CGPoint]()
                    }
                case .tapBryn:
                    if node.name == CharacterNames.bryn.rawValue {
                        scene.characterTapped(character: .bryn)
                        scene.moveToBrynTapTutorial()
                        controlState = .tapEnemy
                    }
                case .tapEnemy:
                    if node.name == EnemyNames.enemy1.rawValue {
                        scene.enemyTapped(enemy: .enemy1)
                        scene.moveToDrawingTutorial()
                        controlState = .drawIsa
                    }
                case .drawIsa:
                    if node.name == runeNodeName {
                        let runeCheck = drawingManager.checkTouches()
                        if runeCheck == .isa {
                            scene.removeEmitters()
                            drawingManager.reset()
                            controlState = .runeDrawn
                            scene.placeRuneAtPoint(rune: runeCheck, location: touch.location(in: scene))
                            scene.moveToRuneDrawnTutorial()
                        } else {
                            print("name: \(node.name)")
                            scene.runeDrawingFailed()
                        }
                    } else {
                        print("node name: \(node.name)")
                        print("Getting to the else")
                        scene.removeEmitters()
                        drawingManager.reset()
                    }
                case .runeDrawn:
                    if node.name == EnemyNames.enemy1.rawValue {
                        scene.usedRuneOnEnemy(enemy: .enemy1)
                        scene.endTutorial()
                    }
                }
            }
        }
    }
    
    func assessNodesForCurrentEnemy(_ touch: UITouch) {
        let nodesAtPoint = scene.nodes(at: touch.location(in: scene))
        for node in nodesAtPoint {
            switch node.name {
            case EnemyNames.enemy1.rawValue:
                sigurdTouchManager.currentEnemy = .enemy1
            case EnemyNames.enemy2.rawValue:
                sigurdTouchManager.currentEnemy = .enemy2
            case EnemyNames.enemy3.rawValue:
                sigurdTouchManager.currentEnemy = .enemy3
            case EnemyNames.enemy4.rawValue:
                sigurdTouchManager.currentEnemy = .enemy4
            default:
                sigurdTouchManager.currentEnemy = sigurdTouchManager.currentEnemy
            }
        }
    }
}
