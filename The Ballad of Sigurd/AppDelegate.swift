//
//  AppDelegate.swift
//  The Ballad of Sigurd
//
//  Created by Zach Babb on 2/21/19.
//  Copyright © 2019 Planet Nine. All rights reserved.
//

import UIKit
import PlanetNineGateway

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    struct GatewayTimestampTuple {
        let gatewayName: String
        let timestamp = "".getTime()
        func toString() -> String {
            return "{\"gatewayName\":\"\(gatewayName)\",\"timestamp\":\"\(timestamp)\"}"
        }
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true) else {
            print("Invalid URL or path missing")
            return false
        }
        
        guard let success = components.queryItems![0].value else {
            print("Unsuccessful")
            return true
        }
        guard let userId = components.queryItems![1].value else {
            print("No userId")
            return true
        }
        if success == "true" && userId != "0" {
            let gatewayTimestampTuple = GatewayTimestampTuple(gatewayName: "The-Ballad-of-Sigurd-dev")
            let signature = Crypto().signMessage(message: gatewayTimestampTuple.toString())
            _ = PlanetNineUser(userId: Int(userId)!, gatewayName: "The-Ballad-of-Sigurd-dev", timestamp: gatewayTimestampTuple.timestamp, signature: signature) { pnUser in
                print(pnUser)
                UserModel().saveUser(user: pnUser)
            }
        }
        return true
    }

}

