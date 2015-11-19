//
//  AppDelegate.swift
//  TidyCo
//
//  Created by Aaron Weaver on 10/8/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize Parse and analytic tools.
        Parse.enableLocalDatastore()
        Parse.setApplicationId("Bry2OJhYY86g53zIevDcjxBJBZw7SArIZ74ndEz7", clientKey: "tl1a0WEHrCVGwPZeICg9CalUdJuoIBqCnFsoykld")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        // Register Parse subclasses to enable database integration.
        Employee.registerSubclass()
        Floor.registerSubclass()
        Room.registerSubclass()
        Service.registerSubclass()
        Timer.registerSubclass()
        ServiceType.registerSubclass()
        EmployeeType.registerSubclass()
        
        let loginDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let employeeId: String = loginDefaults.valueForKey(StringUtils.loginDefaults) as? String
        {
            print("Employee ID: \(employeeId)")
            //Select appropriate view controller for the user
        }
        else
        {
            //Select login view for the user
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

