//
//  AppDelegate.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let nav:UINavigationController = UINavigationController.init(rootViewController: RootController());
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
     
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        
    }


}

