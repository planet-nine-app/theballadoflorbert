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
    var drawingManager = DrawingManager()
    
    init(scene: TutorialScene) {
        self.scene = scene
    }
    
    override func touchesBeganHandler(_ touches: Set<UITouch>) {
        print("Touch began")
    }
    
    override func touchesMovedHandler(_ touches: Set<UITouch>) {
        
    }
    
    override func touchesEndedHandler(_ touches: Set<UITouch>) {
        
    }
}
