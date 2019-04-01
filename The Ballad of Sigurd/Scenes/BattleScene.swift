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
    
    var emitters = [SKEmitterNode]()
    var battleCharacters = [AbstractBattleCharacter]()
    var battleEnemies = [AbstractBattleEnemy]()
    var runeUsed: AbstractBattleRune?
    let battleMath = BattleMath()
    var lastTime: TimeInterval?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        let backgroundNode = SKSpriteNode(imageNamed: "Background@3x.png")
        backgroundNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        backgroundNode.zPosition = ZPositions.background.rawValue
        backgroundNode.name = "Background"
        
        guard party != nil else {
            print("No Party set cannot perform other operations")
            return
        }
        
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
        runeNode.lineWidth = 0
        self.addChild(runeNode)
    }
    
    func addCharacters() {
        let sigurd = party?.sigurd
        let bryn = party?.bryn
        let anders = party?.anders
        let battleSigurd = BattleSigurd(character: sigurd!)
        let battleBryn = BattleBryn(character: bryn!)
        let battleAnders = BattleAnders(character: anders!)
        self.addChild(battleSigurd.spriteNode)
        self.addChild(battleBryn.spriteNode)
        self.addChild(battleAnders.spriteNode)
        
        battleCharacters.append(battleSigurd)
        battleCharacters.append(battleBryn)
        battleCharacters.append(battleAnders)
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
            battleCharacters[2].relinquishPriority()
            battleCharacters[0].tapped()
        case .bryn:
            battleCharacters[0].relinquishPriority()
            battleCharacters[2].relinquishPriority()
            battleCharacters[1].tapped()
        case .anders:
            battleCharacters[0].relinquishPriority()
            battleCharacters[1].relinquishPriority()
            battleCharacters[2].tapped()
        }
    }
    
    func enemyTapped(enemy: EnemyNames) {
        print("Enemy tapped")
        switch enemy {
        case .enemy1:
            print(battleCharacters[1].characterNode.position)
            let brynAttack = BrynAttack(at: battleCharacters[1].spriteNode.position, to: battleEnemies[0].spriteNode.position)
            brynAttack.addToSceneAndRunWithCompletion(scene: self) {
                self.battleEnemies[0].damage(self.battleMath.calculateBrynDamageToEnemy(enemy: self.battleEnemies[0], bryn: self.battleCharacters[1] as! BattleBryn), scene: self)
            }
        case .enemy2:
            battleEnemies[1].damage(battleMath.calculateBrynDamageToEnemy(enemy: battleEnemies[1], bryn: battleCharacters[1] as! BattleBryn), scene: self)
        case .enemy3:
            battleEnemies[2].damage(battleMath.calculateBrynDamageToEnemy(enemy: battleEnemies[2], bryn: battleCharacters[1] as! BattleBryn), scene: self)
        case .enemy4:
            battleEnemies[3].damage(battleMath.calculateBrynDamageToEnemy(enemy: battleEnemies[3], bryn: battleCharacters[1] as! BattleBryn), scene: self)
        }
        
        battleCharacters[1].playerCharacter.currentStamina = battleCharacters[1].playerCharacter.currentStamina - 15
    }
    
    func enemySlashed(enemy: EnemyNames) {
        print("Enemy tapped")
        switch enemy {
        case .enemy1:
            let sigurdAttack = SigurdAttack(at: battleCharacters[0].spriteNode.position, to: battleEnemies[0].spriteNode.position)
            sigurdAttack.addToSceneAndRunWithCompletion(scene: self) {
                self.battleEnemies[0].damage(self.battleMath.calculateSigurdDamageToEnemy(enemy: self.battleEnemies[0], sigurd: self.battleCharacters[0] as! BattleSigurd), scene: self)
            }
            
            
        case .enemy2:
            battleEnemies[1].damage(battleMath.calculateSigurdDamageToEnemy(enemy: battleEnemies[1], sigurd: battleCharacters[0] as! BattleSigurd), scene: self)
        case .enemy3:
            battleEnemies[2].damage(battleMath.calculateSigurdDamageToEnemy(enemy: battleEnemies[2], sigurd: battleCharacters[0] as! BattleSigurd), scene: self)
        case .enemy4:
            battleEnemies[3].damage(battleMath.calculateSigurdDamageToEnemy(enemy: battleEnemies[3], sigurd: battleCharacters[0] as! BattleSigurd), scene: self)
        }
        battleCharacters[0].playerCharacter.currentStamina = battleCharacters[0].playerCharacter.currentStamina - 20
    }
    
    func enemyZapped(enemy: EnemyNames) {
        switch enemy {
        case .enemy1:
            let andersAttack = AndersAttack(at: battleCharacters[2].spriteNode.position, to: battleEnemies[0].spriteNode.position)
            andersAttack.addToSceneAndRunWithCompletion(scene: self) {
                self.battleEnemies[0].damage(self.battleMath.calculateAndersDamageToEnemy(enemy: self.battleEnemies[0], anders: self.battleCharacters[2] as! BattleAnders), scene: self)
            }
        case .enemy2:
            print("Handle more enemies")
        case .enemy3:
            print("Handle more enemies")
        case .enemy4:
            print("Handle more enemies")
            
        }
        battleCharacters[2].playerCharacter.currentStamina = battleCharacters[2].playerCharacter.currentStamina - 25
    }
    
    func addRuneDrawingEmitterNode(_ location: CGPoint) {
        guard let particle = SKEmitterNode(fileNamed: "RuneDrawing.sks") else {
            return
        }
        particle.position = location
        emitters.append(particle)
        self.addChild(particle)
    }
    
    func removeEmitters() {
        for particle in emitters {
            particle.removeFromParent()
        }
        emitters = [SKEmitterNode]()
    }
    
    func placeRuneAtPoint(rune: Runes, location: CGPoint) {
        
        switch rune {
        case .isa:
            runeUsed = BattleIsa()
        case .ansuz:
            runeUsed = AbstractBattleRune()
        case .vestri:
            runeUsed = AbstractBattleRune()
        case .none:
            print("Can't use a none rune")
            return
        }
        runeUsed!.spriteNode.position = location
        self.addChild(runeUsed!.spriteNode)
    }
    
    func moveRuneToPoint(_ location: CGPoint) {
        guard runeUsed != nil else {
            print("Can't move a nil rune")
            return
        }
        let runeAction = SKAction.move(to: location, duration: 0.15)
        runeUsed!.spriteNode.run(runeAction)
    }
    
    func removeRuneFromScene() {
        guard runeUsed != nil else {
            print("Can't remove a nil rune")
            return
        }
        runeUsed!.spriteNode.removeFromParent()
        runeUsed = nil
    }
    
    func usedRuneOnEnemy(enemy: EnemyNames) {
        guard runeUsed != nil else {
            print("Can't use a nil rune")
            return
        }
        var enemyToUseRuneOn: AbstractBattleEnemy
        switch enemy {
        case .enemy1:
            enemyToUseRuneOn = battleEnemies[0]
        case .enemy2:
            enemyToUseRuneOn = battleEnemies[1]
        case .enemy3:
            enemyToUseRuneOn = battleEnemies[2]
        case .enemy4:
            enemyToUseRuneOn = battleEnemies[3]
        }
        
        let characterThatUsedRune = battleCharacters.filter { character in
            return character.hasPriority
        }[0]
        
        characterThatUsedRune.playerCharacter.currentMP = characterThatUsedRune.playerCharacter.currentMP - 10
        
        runeUsed!.runAnimationOnEnemy(enemy: enemyToUseRuneOn, character: characterThatUsedRune, scene: self)
    }
    
    func usedRuneOnCharacter(character: CharacterNames) {
        guard runeUsed != nil else {
            print("Can't use a nil rune")
            return
        }
        var characterToUseRuneOn: AbstractBattleCharacter
        switch character {
        case .sigurd:
            characterToUseRuneOn = battleCharacters[0]
        case .bryn:
            characterToUseRuneOn = battleCharacters[1]
        case .anders:
            print("Anders case not handled yet")
            characterToUseRuneOn = battleCharacters[2]
        }
        
        let characterThatUsedRune = battleCharacters.filter { character in
            return character.hasPriority
            }[0]
        
        characterThatUsedRune.playerCharacter.currentMP = characterThatUsedRune.playerCharacter.currentMP - 10
        
        runeUsed!.runAnimationOnCharacter(character: characterToUseRuneOn, runeUsingCharacter: characterThatUsedRune, scene: self)
    }
    
    func whoHasPriority() -> CharacterNames {
        let charactersWithPriority = battleCharacters.filter { character in
            return character.hasPriority
        }
        if charactersWithPriority.count > 0 {
            return charactersWithPriority[0].playerCharacter.name
        }
        return .sigurd //TODO do we want a none character name?
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let theLastTime = lastTime else {
            lastTime = currentTime
            return
        }
        let timeDiff = currentTime - theLastTime
        for battleCharacter in battleCharacters {
            battleCharacter.updateStatusBar(timeDiff)
        }
        lastTime = currentTime
    }
}
