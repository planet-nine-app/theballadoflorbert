//
//  UserModel.swift
//  Planet Nine
//
//  Created by Zach Babb on 11/8/18.
//  Copyright © 2018 Planet Nine. All rights reserved.
//

import Foundation

struct User: Codable {
    var userId = 0
    var userUUID = ""
    var name = "name"
    var locationId = 1
    var powerId = 1
    var powerOrdinal = 0
    var power = 1000
    var lastPowerUsed = "2018-09-05T20:55:52.836Z"
    var powerRegenerationRate = 1.0
    var globalRegenerationRate = 1.666667
    var moveOrdinal = 0
    var lastMove = "2018-09-05T20:55:52.836Z"
    var publicKey = ""
    var keys = [String: String]()
    var location = "1"
    var exits = [String: Int]()
    var nineum = [String]()
    var currentPower = 100
    var nextMove = "2018-09-05T20:55:52.836Z"
}

class UserModel {
        
    private var user: User?
    private let defaults = UserDefaults.standard

    
    init() {
        
    }
    
    func getUser() -> User? {
        return user
    }
    
    func getUserFromJSONData(userData: Data) -> User? {
        var decodedUser = User()
        do {
            decodedUser = try JSONDecoder().decode(User.self, from: userData)
        } catch {
            return nil
        }
        
        if decodedUser.userId == 0 {
            return nil
        }
        
        return decodedUser
    }
    
    func clearUser() {

    }
    
    func saveUser(user: PNUser) {
        Utils().saveEncodableToDefaults(user, key: "user")
    }
}
