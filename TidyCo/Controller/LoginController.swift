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
    @IBOutlet weak var loginButton: UIButton!
    
    var employeeTypeName: String?
    
    var loggedInEmployee: Employee?
    
    
    @IBAction func loginButtonTap(sender: AnyObject) {
        loginCheck(textLoginUser.text!, loginPassword: textLoginPassword.text!)
    }
    
    @IBAction func loginEditChange(sender: AnyObject) {
        checkField()
    }
    @IBAction func passwordEditChange(sender: AnyObject) {
        checkField()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkField() {
        if textLoginUser.text!.isEmpty || textLoginPassword.text!.isEmpty {
            loginButton.enabled = false
        }
        else {
            loginButton.enabled = true
        }
    }
    
    private func loginCheck(loginUser: String, loginPassword: String)
    {
        print("Running login check")
        
        if let foundEmployee: Employee = loginAdapter.checkLoginForEmployee(loginUser, password: loginPassword) {
            print("correct username/password combo")
            
            loggedInEmployee = foundEmployee
            
            // store employeeid in NSUserDefaults
            // get the standard user defaults
            let loggedInStore: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            // put in user defaults
            loggedInStore.setObject(loggedInEmployee?.employeeId, forKey: "employeeId")
            loggedInStore.synchronize()
            
            // successfull login. Go to navigation view
            performSegueWithIdentifier("userNavigationSegue", sender: self)
        }
        else
        {
            print("Failed")
            // Do something to alert the user of incorrect password 'n' stuff.
            let alertController = UIAlertController(title: "Uh Oh!", message: "Incorrect Login ID or Password.\nPlease Try again.", preferredStyle: .Alert)
            
            let okayAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertController.addAction(okayAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        /*
        
        if let employeeLogged: Employee = loginAdapter.checkLoginForEmployee(loginUser, password: loginPassword)
        {
            let employeeStore: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            let employeeType: EmployeeType = employeeLogged[Employee.EMPLOYEE_TYPE_POINTER] as! EmployeeType
            
            employeeTypeName = employeeType.typeName
            
            print("Logged employee's type:  \(employeeTypeName)")
            employeeStore.setObject(employeeLogged.employeeId, forKey: StringUtils.loginDefaults)
           
            employeeStore.setObject(employeeType.typeName, forKey: StringUtils.employeeType)
            
            
            employeeStore.synchronize()
            
            performSegueWithIdentifier("userNavigationSegue", sender: self)
        }
        else
        {
            print("Failed")
            // Do something to alert the user of incorrect password 'n' stuff.
            let alertController = UIAlertController(title: "Uh Oh!", message: "Incorrect Login ID or Password.\nPlease Try again.", preferredStyle: .Alert)
            
            let okayAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertController.addAction(okayAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }

        */
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? UserNavigationViewController {
            destinationVC.loggedInEmployee = loggedInEmployee
        }
    }
}