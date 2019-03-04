//
//  TutorialScene.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 3/1/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class TutorialScene: BattleScene {
    
    var highlightNode: SKShapeNode
    var dialogNode: BattleDialog
    
    override init() {
        highlightNode = SKShapeNode()
        dialogNode = BattleDialog(sizeOf: CGSize(width: 100, height: 100), at: CGPoint(x: 100, y: 100), with: "Hello World")
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        highlightNode = SKShapeNode()
        dialogNode = BattleDialog(sizeOf: CGSize(width: 100, height: 100), at: CGPoint(x: 100, y: 100), with: "Hello World")
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        highlightNode = SKShapeNode()
        dialogNode = BattleDialog(sizeOf: CGSize(width: 100, height: 100), at: CGPoint(x: 100, y: 100), with: "Hello World")
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        controls = TutorialControls(scene: self)
        highlightNode = SKShapeNode(rectOf: CGSize(width: battleCharacters[0].spriteNode.frame.width + 8, height: battleCharacters[0].spriteNode.frame.height + 8))
        highlightNode.position = battleCharacters[0].spriteNode.position
        highlightNode.zPosition = ZPositions.runeNode.rawValue
        highlightNode.strokeColor = UIColor.yellow
        highlightNode.glowWidth = 4.0
        self.addChild(highlightNode)
        
        dialogNode = BattleDialog(sizeOf: CGSize(width: 600, height: 300), at: CGPoint(x: 860, y: 700), with: "Start by tapping Sigurd to have\nSigurd gain priority.")
        dialogNode.addToScene(scene: self)
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
    
    func moveToSigurdSlashTutorial() {
        highlightNode.position = battleEnemies[0].spriteNode.position
        dialogNode.textNode.text = "Now slash across the enemy to attack!"
        
    }
    
    func moveToSelectBrynTutorial() {
        highlightNode.position = battleCharacters[1].spriteNode.position
        dialogNode.textNode.text = "Next give Bryn priority\nby tapping her."
    }
    
    func moveToBrynTapTutorial() {
        highlightNode.position = battleEnemies[0].spriteNode.position
        dialogNode.textNode.text = "Now tap the enemy to throw your\nspear at it!"
    }
    
    func moveToDrawingTutorial() {
        dialogNode.backgroundNode.position = CGPoint(x: 1700, y: 700)
        dialogNode.textNode.text = "Now let's draw a rune. Isa is a vertical\nline drawn from bottom to top.\nIf you need to start over just tap Bryn again."
    }
    
    func moveToRuneDrawnTutorial() {
        dialogNode.textNode.text = "Good! Now to use Isa hold your finger\ndown and drag it over to the enemy."
    }
    
    func endTutorial() {
        dialogNode.backgroundNode.position = CGPoint(x: 860, y: 700)
        dialogNode.textNode.text = "Great work! You're now ready to take on\nthe hordes of The Ballad of Sigurd."
    }
    
    func runeDrawingFailed() {
        dialogNode.textNode.text = "Looks like drawing Isa failed.\nTap Bryn to start drawing again.\nRemember Isa is straight down to up."
    }
}
