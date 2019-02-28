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

struct SigurdTouchManager {
    var currentEnemy: EnemyNames?
    var touchArray = [CGPoint]()
    func wasItASlash() -> Bool {
        if currentEnemy == nil {
            return false
        }
        return true
    }
}

class BattleControls {
    
    let scene: BattleScene
    let runeNodeName = "RuneNode"
    var controlState: ControlStates = .none
    var sigurdTouchManager = SigurdTouchManager()
    var drawingManager = DrawingManager()
    
    init(scene: BattleScene) {
        self.scene = scene
    }
    
    func touchesBeganHandler(_ touches: Set<UITouch>) {
        guard let touch = touches.first else {
            return
        }
        if controlState == .runeDrawn {
            scene.moveRuneToPoint(touch.location(in: scene))
            return
        }
        let nodesAtPoint = scene.nodes(at: touch.location(in: scene))
        for node in nodesAtPoint {
            if node.name == runeNodeName {
                print("rune node name")
                if controlState == .sigurd || controlState == .bryn || controlState == .alvis {
                    controlState = .drawing
                    print("should set state to drawing")
                    drawingManager.startNewTouchArray(location: touch.location(in: scene))
                    scene.addRuneDrawingEmitterNode(touch.location(in: scene))
                }
            }
        }
        if controlState == .sigurd {
            sigurdTouchManager.touchArray.append(touch.location(in: scene))
            assessNodesForCurrentEnemy(touch)
        }
    }
    
    func touchesMovedHandler(_ touches: Set<UITouch>) {
        guard let touch = touches.first else {
            return
        }
        if controlState == .runeDrawn {
            scene.moveRuneToPoint(touch.location(in: scene))
            return
        }
        if controlState == .drawing {
            print("Should be adding locations")
            drawingManager.addLocationToTouchManager(location: touch.location(in: scene))
            scene.addRuneDrawingEmitterNode(touch.location(in: scene))
        }
        if controlState == .sigurd {
            sigurdTouchManager.touchArray.append(touch.location(in: scene))
            assessNodesForCurrentEnemy(touch)
        }
    }
    
    func touchesEndedHandler(_ touches: Set<UITouch>) {
        for touch in touches {
            if controlState == .sigurd {
                if sigurdTouchManager.wasItASlash() {
                    if sigurdTouchManager.currentEnemy != nil {
                        scene.enemySlashed(enemy: sigurdTouchManager.currentEnemy!)
                    }
                }
                sigurdTouchManager.touchArray = [CGPoint]()
                sigurdTouchManager.currentEnemy = nil
            }
            let nodesAtPoint = scene.nodes(at: touch.location(in: scene))
            for node in nodesAtPoint {
                if let nameOfNode = node.name {
                    switch nameOfNode {
                    case CharacterNames.sigurd.rawValue:
                        print("Do Sigurd stuff")
                        if controlState == .none || controlState == .bryn || controlState == .alvis {
                            scene.characterTapped(character: .sigurd)
                            controlState = .sigurd
                        }
                        if controlState == .runeDrawn {
                            scene.usedRuneOnCharacter(character: .sigurd)
                            scene.removeRuneFromScene()
                        }
                    case CharacterNames.bryn.rawValue:
                        print("Do Bryn stuff")
                        if controlState == .none || controlState == .sigurd || controlState == .alvis {
                            scene.characterTapped(character: .bryn)
                            controlState = .bryn
                        }
                        if controlState == .runeDrawn {
                            scene.usedRuneOnCharacter(character: .bryn)
                            scene.removeRuneFromScene()
                        }
                    case EnemyNames.enemy1.rawValue, EnemyNames.enemy2.rawValue, EnemyNames.enemy3.rawValue, EnemyNames.enemy4.rawValue:
                        disambiguateTouchesEnded(nameOfNode: nameOfNode)
                    case runeNodeName:
                        if controlState == .drawing {
                            drawingManager.addLocationToTouchManager(location: touch.location(in: scene))
                            let runeCheck = drawingManager.checkTouches()
                            print("Checked rune and found \(runeCheck)")
                            if runeCheck != Runes.none {
                                print("Draw your rune here")
                                scene.removeEmitters()
                                drawingManager.reset()
                                controlState = .runeDrawn
                                scene.placeRuneAtPoint(rune: runeCheck, location: touch.location(in: scene))
                            }
                        }
                    default:
                        print("Do other stuff here")
                    }
                }
            }
        }
        sigurdTouchManager.touchArray = [CGPoint]()
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
    
    func disambiguateTouchesEnded(nameOfNode: String) {
        var enemy: EnemyNames
        switch nameOfNode {
        case EnemyNames.enemy1.rawValue:
            enemy = .enemy1
        case EnemyNames.enemy1.rawValue:
            enemy = .enemy2
        case EnemyNames.enemy1.rawValue:
            enemy = .enemy3
        case EnemyNames.enemy1.rawValue:
            enemy = .enemy4
        default: enemy = .enemy1
        }
        switch controlState {
        case .sigurd:
            print("Sigurd stuff")
        case .bryn:
            scene.enemyTapped(enemy: enemy)
        case .alvis:
            print("Alvis")
        case .drawing:
            print("Drawing")
        case .runeDrawn:
            print("rune drawn")
            scene.usedRuneOnEnemy(enemy: enemy)
            scene.removeRuneFromScene()
            let characterWhoHasPriority = scene.whoHasPriority()
            switch characterWhoHasPriority {
            case .sigurd:
                controlState = .sigurd
            case .bryn:
                controlState = .bryn
            }
        case .none:
            print("Do nothing")
        }
    }
}
