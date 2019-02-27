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
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        let backgroundNode = SKSpriteNode(imageNamed: "grassy_lake.png")
        backgroundNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(backgroundNode)
        
        addCharacters()
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
}
