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
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        controls = TutorialControls(scene: self)
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
}
