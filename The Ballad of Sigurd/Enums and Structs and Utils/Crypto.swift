//
//  Crypto.swift
//  Planet Nine
//
//  Created by Zach Babb on 11/8/18.
//  Copyright © 2018 Planet Nine. All rights reserved.
//

import Foundation
import JavaScriptCore
import Valet

struct Keys: Codable {
    var privateKey = ""
    var publicKey = ""
}

class Crypto {
    
    let publicKeyKey = "publicKey"
    let privateKeyKey = "privateKey"
    
    func getJSContext() -> JSContext? {
        var jsSourceContents: String = ""
        if let jsSourcePath = Bundle.main.path(forResource: "crypto", ofType: "js") {
            do {
                jsSourceContents = try String(contentsOfFile: jsSourcePath)
            } catch {
                print(error.localizedDescription)
            }
        }
        let context = JSContext()
        context?.evaluateScript(jsSourceContents)
        
        return context
    }
    
    func signMessage(message: String) -> String {
        
        print(message)
        
        let privateKey = Crypto().getKeys()?.privateKey
        
        let context = getJSContext()
        
        let window = context?.objectForKeyedSubscript("window")
        let signMessage = window?.objectForKeyedSubscript("signMessage")
        let signature = signMessage?.call(withArguments: [message, privateKey!])!.toString()
        
        return signature!
    }
    
    func generateKeys(seed: String) -> Keys {
        
        let context = getJSContext()
        
        let window = context?.objectForKeyedSubscript("window")
        let keyGenerator = window?.objectForKeyedSubscript("keyGenerator")
        let generateKeysFunction = keyGenerator?.objectForKeyedSubscript("generateKeys")
        let result = generateKeysFunction?.call(withArguments: [seed])
        let newKeys = Keys(privateKey: ((result?.objectForKeyedSubscript("private")!.toString())!), publicKey: (result?.objectForKeyedSubscript("public")!.toString())!)
        
        let valet = Valet.valet(with: Identifier(nonEmpty: "The-Ballad-of-Sigurd-dev")!, accessibility: .whenUnlocked)
        valet.set(string: newKeys.publicKey, forKey: publicKeyKey)
        valet.set(string: newKeys.privateKey, forKey: privateKeyKey)
        
        return newKeys
    }
    
    func getKeys() -> Keys? {
        
        let valet = Valet.valet(with: Identifier(nonEmpty: "The-Ballad-of-Sigurd-dev")!, accessibility: .whenUnlocked)
        let publicKey = valet.string(forKey: publicKeyKey)
        let privateKey = valet.string(forKey: privateKeyKey)
        
        if publicKey == nil || privateKey == nil {
            print("Could not find keys")
            return nil
        }
        
        let decodedKeys = Keys(privateKey: privateKey!, publicKey: publicKey!)
        
        print("Valet keys")
        print(publicKey)
        print(privateKey)
        
        return decodedKeys
    }
}
