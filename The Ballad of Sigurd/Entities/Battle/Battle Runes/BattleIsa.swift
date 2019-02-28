//
//  BattleVestri.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/28/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit

class BattleIsa: AbstractBattleRune {
    
    override init() {
        super.init()
        spriteNode = SKSpriteNode(imageNamed: "runeIsa.png")
        spriteNode.name = Runes.isa.rawValue
        name = .isa
        spriteNode.setScale(4.0)
        spriteNode.zPosition = ZPositions.rune.rawValue
    }
    
    override func runAnimationOnEnemy(enemy: AbstractBattleEnemy, character: AbstractBattleCharacter, scene: BattleScene) {
        var iceCubeNodes = [SKSpriteNode]()
        var i = 0
        for var _ in 0..<10 {
            let iceCubeNode = SKSpriteNode(imageNamed: "icecube.png")
            let xPlusMinus = CGFloat.plusOrMinus()
            let yPlusMinus = CGFloat.plusOrMinus()
            let cubePosition = CGPoint(x: enemy.spriteNode.position.x + (xPlusMinus * (CGFloat.random(in: 1..<100) + 150.0)), y: enemy.spriteNode.position.y + (yPlusMinus * (CGFloat.random(in: 1..<100) + 150.0)))
            iceCubeNode.position = cubePosition
            iceCubeNode.alpha = 0.0
            iceCubeNode.zPosition = ZPositions.effect.rawValue
            iceCubeNodes.append(iceCubeNode)
            scene.addChild(iceCubeNode)
            let fadeInAction = SKAction.fadeIn(withDuration: 0.25)
            let rotationAction = SKAction.rotate(byAngle: 16, duration: 0.3)
            let movementAction = SKAction.move(to: enemy.spriteNode.position, duration: 0.15)
            let sequence = SKAction.sequence([fadeInAction, rotationAction, movementAction])
            iceCubeNode.run(sequence) {
                iceCubeNode.removeFromParent()
                i = i + 1
                if i == 10 {
                    enemy.damage(BattleMath().calculateMagicalDamageToEnemy(character: character, enemy: enemy), scene: scene)
                }
            }
        }
    }
    
    override func runAnimationOnCharacter(character: AbstractBattleCharacter, runeUsingCharacter: AbstractBattleCharacter, scene: BattleScene) {
        let cloudNode = SKSpriteNode(imageNamed: "cloud2.png")
        guard let rainEmitter = SKEmitterNode(fileNamed: "HealingRain.sks") else {
            print("Could not initialize rain emitter")
            return
        }
        cloudNode.position = CGPoint(x: character.spriteNode.position.x + 60, y: character.spriteNode.position.y + 200)
        cloudNode.zPosition = ZPositions.effect.rawValue
        rainEmitter.position = cloudNode.position
        rainEmitter.zPosition = ZPositions.effect.rawValue
        let movementAction = SKAction.move(to: CGPoint(x: character.spriteNode.position.x - 60, y: character.spriteNode.position.y + 200), duration: 1.5)
        scene.addChild(cloudNode)
        scene.addChild(rainEmitter)
        cloudNode.run(movementAction) {
            cloudNode.removeFromParent()
        }
        rainEmitter.run(movementAction) {
            rainEmitter.removeFromParent()
            character.heal(BattleMath().calculateHealingToCharacter(character: character, characterThatUsedRune: runeUsingCharacter), scene: scene)
        }
    }
}
