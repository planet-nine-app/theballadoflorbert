//
//  Utils.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/25/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    func saveEncodableToDefaults<T: Encodable>(_ object: T, key: String) {
        do {
            let jsonData = try JSONEncoder().encode(object)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            let defaults = UserDefaults.standard
            defaults.set(jsonString, forKey: key)
        } catch {
            print("Error setting default")
            print(error)
        }
    }
}

extension Int {
    static func statIncrease() -> Int {
        if Bool.random() {
            return 2
        }
        if Bool.random() {
            return 3
        }
        return 1
    }
    
    static func plusOrMinus() -> Int {
        if Bool.random() {
            return 1
        }
        return -1
    }
}

extension CGFloat {
    static func plusOrMinus() -> CGFloat {
        if Bool.random() {
            return 1.0
        }
        return -1.0
    }
}

extension UIColor {
    struct PlanetNineColors {
        static var primary: UIColor { return UIColor(red: 93/255, green: 193/255, blue: 185/255, alpha: 1.0)}
        static var closePrimary: UIColor { return UIColor(red: 90/255, green: 196/255, blue: 189/255, alpha: 1.0)}
        static var secondary: UIColor { return UIColor(red: 228/255, green: 210/255, blue: 197/255, alpha: 1.0)}
        static var textColor: UIColor { return UIColor(red: 40/255, green: 100/255, blue: 90/255, alpha: 1.0)}
        static var darkPrimary: UIColor { return UIColor(red: 40/255, green: 100/255, blue: 97/255, alpha: 1.0)}
        static var darkSecondary: UIColor { return UIColor(red: 137/255, green: 123/255, blue: 116/255, alpha: 1.0)}
        static var blankInventory: UIColor { return UIColor(red: 155/255, green: 199/255, blue: 196/255, alpha: 1.0)}
    }
    
    struct StatusBarColors {
        static var health: UIColor { return UIColor(red: 70/255, green: 182/255, blue: 90/255, alpha: 1.0)}
        static var stamina: UIColor { return UIColor(red: 245/255, green: 219/255, blue: 205/255, alpha: 1.0)}
        static var magic: UIColor { return UIColor(red: 49/255, green: 82/255, blue: 144/255, alpha: 1.0)}
    }
}
