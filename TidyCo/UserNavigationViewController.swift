//
//  UserNavigationViewController.swift
//  TidyCo
//
//  Created by KEETON AUSTIN R on 11/19/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class UserNavigationViewController: UINavigationController {

    let employeeOps = ParseEmployeeStorageAdapter()
    var loggedInEmployee: Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if loggedInEmployee?.employeeType.typeName == "admin" || loggedInEmployee?.employeeType.typeName == "manager" {
            performSegueWithIdentifier("managerSegue", sender: self)
        }
        else {
            performSegueWithIdentifier("employeeSegue", sender: self)
        }
        

        // Do any additional setup after loading the view.
        
        //navigationController?.navigationBar.tintColor = UIColor(red: 47.0/255.0, green: 157.0/255.0, blue: 215.0/255.0, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "employeeSegue"
        {
            if let destination = segue.destinationViewController as? EmployeeRoomTableViewController
            {
                destination.employee = loggedInEmployee
            }
        }
    }


}
