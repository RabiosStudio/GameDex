//
//  AppDelegate.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 14/08/2023.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        FirebaseApp.configure()
        
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }
}
