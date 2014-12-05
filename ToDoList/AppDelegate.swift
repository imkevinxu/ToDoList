//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Kevin Xu on 11/25/14.
//  Copyright (c) 2014 Kevin Xu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.loadDefaultPreferences()
        return true
    }
    
    func loadDefaultPreferences() {
        let defaultPreferencesFile: NSURL = NSBundle.mainBundle().URLForResource("DefaultPreferences", withExtension: "plist")!
        let defaultPreferences = NSDictionary(contentsOfURL: defaultPreferencesFile)!
        NSUserDefaults.standardUserDefaults().registerDefaults(defaultPreferences)
    }
    
    func setDummyKeychainPassword() {
        SSKeychain.setPassword("password", forService: "ToDoList", account: "user")
    }
    
    func getDummyKeychainPassword() -> String {
        return SSKeychain.passwordForService("ToDoList", account: "user")
    }
}

