//
//  SpecialPowerButton.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 4/2/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import SpriteKit
import PlanetNineGateway

class SpecialPowerButton {
    
    let backingNode: SKShapeNode
    
    init() {
        backingNode = SKShapeNode(path: CGPath(roundedRect: CGRect(x: 0, y: 0, width: 604, height: 84), cornerWidth: 42, cornerHeight: 42, transform: nil))
        backingNode.fillColor = UIColor.white
        backingNode.lineWidth = 0
        backingNode.zPosition = 105.0
        backingNode.name = "Special Power"
        
        let circleNode = SKShapeNode(circleOfRadius: 36)
        circleNode.fillColor = UIColor.PlanetNineColors.secondary
        circleNode.lineWidth = 0
        circleNode.zPosition = 106.0
        circleNode.position = CGPoint(x: 42, y: 42)
        
        let specialNode = SKLabelNode(text: "Special Power")
        specialNode.fontName = "Orbitron-Bold"
        specialNode.fontColor = UIColor.PlanetNineColors.primary
        specialNode.fontSize = 36
        specialNode.position = CGPoint(x: 104, y: 32)
        specialNode.zPosition = 106.0
        specialNode.horizontalAlignmentMode = .left
        
        let powerNode = SKLabelNode(text: "300 Power")
        powerNode.fontName = "Ubuntu-Medium"
        powerNode.fontColor = UIColor.PlanetNineColors.primary
        powerNode.fontSize = 28
        powerNode.position = CGPoint(x: 580, y: 32)
        powerNode.zPosition = 106.0
        powerNode.horizontalAlignmentMode = .right
        
        backingNode.addChild(circleNode)
        backingNode.addChild(specialNode)
        backingNode.addChild(powerNode)
        
        guard let user = UserModel().getUser() else {
            print("Special Power Button could not find user")
            return
        }
        if user.currentPower < 300 {
            backingNode.alpha = 0.5
        }
    }
    
    func tapped(scene: BattleScene) {
        print("Use Power here")
        guard let user = UserModel().getUser() else {
            print("Special Power Button could not find user in tapped")
            return
        }
        if user.currentPower < 300 {
            return
        }
        //Add Gateway call here
        let usePowerModel = UsePowerModel()
        let usePowerAtOngoingGateway = UsePowerAtOngoingGateway(totalPower: 300, partnerName: "team-planet-nine", gatewayName: "The-Ballad-of-Sigurd-dev", userId: user.userId, publicKey: Crypto().getKeys()!.publicKey, ordinal: (user.powerOrdinal + 1), description: "Special Power usage in The Ballad of Sigurd")
        let usePowerAtOngoingGatewayWithSignature = usePowerModel.addSignatureToUsePowerAtOngoingGatewayObject(object: usePowerAtOngoingGateway, signature: Crypto().signMessage(message: usePowerAtOngoingGateway.toString()))
        usePowerModel.usePowerAtOngoingGateway(gatewayObjectWithSignature: usePowerAtOngoingGatewayWithSignature) { error, user in
            if error != nil || user == nil {
                print("There was an error in the call")
                return
            }
            let userString = String(data: user!, encoding: .utf8)
            print(userString)
        }
        
        scene.useSpecialPower()
    }
}
