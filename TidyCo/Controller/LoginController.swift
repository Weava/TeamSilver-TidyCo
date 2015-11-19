//
//  LoginController.swift
//  TidyCo
//
//  Created by Aaron Weaver on 10/15/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import Foundation

class LoginController : UIViewController
{
    let loginAdapter: ParseEmployeeStorageAdapter = ParseEmployeeStorageAdapter()
    
    @IBOutlet weak var textLoginUser: UITextField!
    @IBOutlet weak var textLoginPassword: UITextField!
    
    var employeeTypeName: String?
    
    
    @IBAction func loginButtonTap(sender: AnyObject) {
        loginCheck(textLoginUser.text!, loginPassword: textLoginPassword.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Login controller, starting")
        //loginCheck()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loginCheck(loginUser: String, loginPassword: String)
    {
        print("Running login check")
        //let loginUser: String = "testMaint"
        //let loginPassword: String = "realPass"
        
        if let employeeLogged: Employee = loginAdapter.checkLoginForEmployee(loginUser, password: loginPassword)!
        {
            let employeeStore: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            let employeeType: EmployeeType = employeeLogged[Employee.EMPLOYEE_TYPE_POINTER] as! EmployeeType
            
            employeeTypeName = employeeType.typeName
            
            print("Logged employee's type:  \(EmployeeType.getEmployeeTypeValue(employeeType)!.rawValue)")
            employeeStore.setObject(employeeLogged.employeeId, forKey: StringUtils.loginDefaults)
           
            employeeStore.setObject(employeeType.typeName, forKey: StringUtils.employeeType)
            
            
            employeeStore.synchronize()
            
            performSegueWithIdentifier("userNavigationSegue", sender: self)
        }
        else
        {
            print("Failed")
            // Do something to alert the user of incorrect password 'n' stuff.
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? UserNavigationViewController {
            
            destinationVC.isManager = true
            
            // Disabled for testing purposes
            /*
            if employeeTypeName == "admin" || employeeTypeName == "manager" {
                destinationVC.isManager = true
            }
            else {
                destinationVC.isEmployee = true
            }
            */
        }
    }
}