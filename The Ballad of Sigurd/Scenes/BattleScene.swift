//
//  BattleScene.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/26/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class BattleScene: AbstractScene {
    
    var battleCharacters = [AbstractBattleCharacter]()
    var battleEnemies = [AbstractBattleEnemy]()
    var controls: BattleControls?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        let backgroundNode = SKSpriteNode(imageNamed: "grassy_lake.png")
        backgroundNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        backgroundNode.zPosition = ZPositions.background.rawValue
        
        
        self.addChild(backgroundNode)
        
        controls = BattleControls(scene: self)
        
        addRuneNode()
        addCharacters()
        addEnemies()
    }
    
    func addRuneNode() {
        let runeNode = SKShapeNode(rect: CGRect(x: 300, y: 0, width: 1000, height: 1280))
        runeNode.zPosition = ZPositions.runeNode.rawValue
        runeNode.name = "RuneNode"
        self.addChild(runeNode)
    }
    
    func addCharacters() {
        let sigurd = AbstractPlayerCharacter(named: .sigurd)
        let bryn = AbstractPlayerCharacter(named: .bryn)
        let battleSigurd = BattleSigurd(character: sigurd)
        let battleBryn = BattleBryn(character: bryn)
        self.addChild(battleSigurd.spriteNode)
        self.addChild(battleBryn.spriteNode)
        
        battleCharacters.append(battleSigurd)
        battleCharacters.append(battleBryn)
    }
    
    func addEnemies() {
        let woodElemental = WoodElemental()
        woodElemental.spriteNode.position = BattlePositions().enemy1
        woodElemental.spriteNode.name = EnemyNames.enemy1.rawValue
        self.addChild(woodElemental.spriteNode)
        
        battleEnemies.append(woodElemental)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        controls!.touchesBeganHandler(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        controls!.touchesMovedHandler(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        controls!.touchesEndedHandler(touches)
    }
    
    func characterTapped(character: CharacterNames) {
        switch character {
        case .sigurd:
            battleCharacters[1].relinquishPriority()
            battleCharacters[0].tapped()
        case .bryn:
            battleCharacters[0].relinquishPriority()
            battleCharacters[1].tapped()
        }
    }
    
    func enemyTapped(enemy: EnemyNames) {
        print("Enemy tapped")
        switch enemy {
        case .enemy1:
            battleEnemies[0].damage(15)
            let damage = Damage(15, location: battleEnemies[0].spriteNode.position)
            damage.addToSceneAndRun(scene: self)
        case .enemy2:
            battleEnemies[1].damage(15)
        case .enemy3:
            battleEnemies[2].damage(15)
        case .enemy4:
            battleEnemies[3].damage(15)
        }
    }
}
