//
//  UserNavigationViewController.swift
//  TidyCo
//
//  Created by KEETON AUSTIN R on 11/19/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class UserNavigationViewController: UINavigationController {

    var isManager = false
    var isEmployee = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isManager {
            performSegueWithIdentifier("managerSegue", sender: self)
        }
        else if isEmployee {
            performSegueWithIdentifier("employeeSegue", sender: self)
        }

        // Do any additional setup after loading the view.
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
