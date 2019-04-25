//
//  GameScene.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/21/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import SpriteKit
import GameplayKit
import PlanetNineGateway

//TODO: Where should this struct live?
struct GatewayKey: Codable {
    var gatewayName: String
    var publicKey: String
    func toString() -> String {
        return "{\"gatewayName\":\"\(gatewayName)\",\"publicKey\":\"\(publicKey)\"}"
    }
}

class GameScene: SKScene {
    
    struct GatewayTimestampTuple {
        let gatewayName: String
        let timestamp = "".getTime()
        func toString() -> String {
            return "{\"gatewayName\":\"\(gatewayName)\",\"timestamp\":\"\(timestamp)\"}"
        }
    }
    
    private var connectButton = SKLabelNode()
    private var playButton = SKLabelNode()
    var user: PNUser?
    
    override func didMove(to view: SKView) {
        
        addTitle()
        addMenuButtons()
        
        let inventoryManager = InventoryManager()
        let abstractPlayerCharacter = AbstractPlayerCharacter(named: .bryn)
        for var _ in 1...50 {
            abstractPlayerCharacter.levelUp()
        }
        
        user = UserModel().getUser()
        
        if user != nil {
            let gatewayTimestampTuple = GatewayTimestampTuple(gatewayName: "The-Ballad-of-Sigurd-dev")
            let signature = Crypto().signMessage(message: gatewayTimestampTuple.toString())
            let _ = PlanetNineUser(userId: user!.userId, gatewayName: "The-Ballad-of-Sigurd-dev", timestamp: gatewayTimestampTuple.timestamp, signature: signature) { pnUser in
                print(pnUser)
                UserModel().saveUser(user: pnUser)
                self.user = UserModel().getUser()
            }
        }
    }
    
    func addTitle() {
        let labelNode = SKLabelNode(text: "The Ballad of Lorbert")
        labelNode.fontColor = UIColor.PlanetNineColors.secondary
        labelNode.fontName = "Orbitron-Bold"
        labelNode.position = CGPoint(x: 0, y: 100)
        self.addChild(labelNode)
    }
    
    func addMenuButtons() {
        connectButton = SKLabelNode(text: "Connect Planet Nine Account")
        connectButton.fontColor = UIColor.PlanetNineColors.primary
        connectButton.fontSize = 17
        connectButton.fontName = "Ubuntu-Medium"
        connectButton.position = CGPoint(x: 0, y: -60)
        connectButton.name = "connectButton"
        
        playButton = SKLabelNode(text: "Play")
        playButton.fontColor = UIColor.PlanetNineColors.primary
        playButton.fontSize = 17
        playButton.fontName = "Ubuntu-Medium"
        playButton.position = CGPoint(x: 0, y: -100)
        playButton.name = "playButton"
        if user == nil {
            playButton.alpha = 0.3
        }
        
        self.addChild(connectButton)
        self.addChild(playButton)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        let nodesAtPoint = self.nodes(at: pos)
        for node in nodesAtPoint {
            if let nameOfNode = node.name {
                switch nameOfNode {
                case "connectButton":
                    print("Connect button tapped")
                    connectAccount()
                case "playButton":
                    print("Play button tapped")
                    play()
                default:
                    print("Default")
                }
            } else {
                print("No Name")
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func connectAccount() {
        var keys = Crypto().getKeys()
        if keys == nil {
            keys = Crypto().generateKeys(seed: "The Ballad of Sigurd dev")
        }
        let gatewayKey = GatewayKey(gatewayName: "The-Ballad-of-Sigurd-dev", publicKey: keys!.publicKey)
        let signature = Crypto().signMessage(message: gatewayKey.toString())
        
        let planetNineGateway = PlanetNineGateway()
        planetNineGateway.ongoingGateway(gatewayName: "The-Ballad-of-Sigurd-dev", publicKey: keys!.publicKey, gatewayURL: "theballadofsigurd://ongoing", signature: signature)
        planetNineGateway.askForOngoingGatewayUsage()
    }
    
    func play() {
        
        let party = Party()
        
        //let inventoryScene = InventoryScene(size: CGSize(width: 1920, height: 1280))
        
        if UserModel().getUser() == nil {
            print("Please connect a user account first")
            return
        }
        let inventoryScene = InventoryScene(size: CGSize(width: 667, height: 375))
        inventoryScene.scaleMode = .aspectFit
        inventoryScene.party = party
        //inventoryScene.scaleMode = .aspectFill
        self.view?.presentScene(inventoryScene)
        /*let battleScene = BattleScene(size: CGSize(width: 1920, height: 1280))
        battleScene.scaleMode = .fill
        self.view?.presentScene(battleScene)*/
        /*let tutorialScene = TutorialScene(size: CGSize(width: 1920, height: 1280))
        tutorialScene.scaleMode = .fill
        tutorialScene.presentingScene = self
        self.view?.presentScene(tutorialScene)*/
    }
    
    override func didFinishUpdate() {
        super.didFinishUpdate()
        if user != nil {
            playButton.alpha = 1.0
        }
    }
}

