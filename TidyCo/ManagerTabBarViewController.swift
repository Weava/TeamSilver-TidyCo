//
//  ManagerTabBarViewController.swift
//  TidyCo
//
//  Created by KEETON AUSTIN R on 11/17/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class ManagerTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //UITabBar.appearance().barTintColor = UIColor(red: 47.0/255.0, green: 157.0/255.0, blue: 255.0, alpha: 1.0)

        // Do any additional setup after loading the view.
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        for item in self.tabBar.items! {
            if let image = item.image {
                item.image = image.imageWithRenderingMode(.AlwaysOriginal)
            }
            item
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
