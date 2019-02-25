//
//  UserModel.swift
//  Planet Nine
//
//  Created by Zach Babb on 11/8/18.
//  Copyright © 2018 Planet Nine. All rights reserved.
//

import Foundation
import PlanetNineGateway

class UserModel {
    let defaults = UserDefaults.standard
    
    func getUser() -> PNUser? {
        guard let jsonString = defaults.string(forKey: "user") else { return nil }
        let jsonData = jsonString.data(using: String.Encoding.utf8)
        var decodedUser = PNUser()
        do {
            let json = try JSONSerialization.jsonObject(with: jsonData!, options: .allowFragments)
            decodedUser = try JSONDecoder().decode(PNUser.self, from: jsonData!)
        } catch {
            print("Error getting user")
            print(error)
        }
        
        return decodedUser
    }
    
    func saveUser(user: PNUser) {
        Utils().saveEncodableToDefaults(user, key: "user")
    }
    
    func saveUserFromJSON(user: String) {
        defaults.set(user, forKey: "user")
    }
    
    func clearUser() {
        defaults.set(nil, forKey: "user")
    }
}
