//
//  AppDelegate.swift
//  RepoStars
//
//  Created by Erik Nascimento on 12/12/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let v = ViewController()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = v
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

