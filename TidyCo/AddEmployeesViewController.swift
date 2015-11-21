//
//  AddEmployeesViewController.swift
//  TidyCo
//
//  Created by KEETON AUSTIN R on 11/17/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class AddEmployeesViewController: UIViewController {
    
     var firstName = String()
     var middleInitial = String()
     var lastName = String()
     var employeeId = String()
     var storeNumber = String()
     var loginId = String()
     var hashedPassword = String()
    
    @IBOutlet weak var employeeNameOutlet: UITextField!
    
    @IBOutlet weak var EmployeeIdOutlet: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        let str : String = "NewEmp2"
        
        firstName = str
        middleInitial = str
        lastName = str
        employeeId = str
        storeNumber = str
        loginId = str
        hashedPassword = str
        
    }


}
