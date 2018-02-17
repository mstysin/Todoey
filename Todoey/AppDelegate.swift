//
//  AppDelegate.swift
//  Todoey
//
//  Created by mstysin on 1/2/18.
//  Copyright © 2018 Stysin Technoogies. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            let realm = try Realm()
        } catch {
            print("Error initialising realm, \(error)")
        }
        
        return true
    }


}

