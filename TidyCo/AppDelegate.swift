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
        
        
        
        
        print("in AppDelegate.swift: didFinishLaunchingWithOptions")
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
        
        
        
        if let employeeId = NSUserDefaults.standardUserDefaults().valueForKey("employeeId") {
            if let loggedInEmployee: Employee = ParseEmployeeStorageAdapter().getEmployeeByEmployeeId(employeeId as! String) {
                self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                let userController: UserNavigationViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("userController") as! UserNavigationViewController
                userController.loggedInEmployee = loggedInEmployee
                
                self.window?.rootViewController = userController
                self.window?.makeKeyAndVisible()
            }
        }

        
        
        
        /*
        let loginDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let employeeOps = ParseEmployeeStorageAdapter()
        if let employeeId: String = loginDefaults.valueForKey(StringUtils.loginDefaults) as? String
        {
            print("Employee ID: \(employeeId)")
            //Select appropriate view controller for the user
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let userController: UserNavigationViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("userController") as! UserNavigationViewController
            
            //let employeeType: String = (loginDefaults.valueForKey(StringUtils.employeeType) as? String)!
            let employeeType = employeeOps.getEmployeeByEmployeeId(employeeId)?.employeeType.typeName
            
            print("Employee type: \(employeeType)")
            
            // Disabled check for Testing
            // Set userController.isManager or userController.isEmployee to true for the respective storyboards
            
            if employeeType == "admin" || employeeType == "manager" {
                userController.isManager = true
            }
            else {
                userController.isEmployee = true
                userController.employeeId = employeeId
            }
            
            userController.isEmployee = true
            userController.isManager = false
            
            
            self.window?.rootViewController = userController
            self.window?.makeKeyAndVisible()
        }
        else
        {
            print("in AppDelgate: no login --> send to login view")
            //Select login view for the user
            //The app was found to not have any login information from last time.
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController: LoginController = mainStoryBoard.instantiateViewControllerWithIdentifier("loginController") as! LoginController
            
            self.window?.rootViewController = loginViewController
            self.window?.makeKeyAndVisible()
            
        }
        */
        
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

