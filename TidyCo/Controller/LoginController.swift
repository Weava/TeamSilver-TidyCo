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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Login controller, starting")
        loginCheck()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loginCheck()
    {
        print("Running login check")
        let loginUser: String = "testMaint"
        let loginPassword: String = "realPass"
        
        if let employeeLogged: Employee = loginAdapter.checkLoginForEmployee(loginUser, password: loginPassword)!
        {
            let employeeStore: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            let employeeType: EmployeeType = employeeLogged[Employee.EMPLOYEE_TYPE_POINTER] as! EmployeeType
            
            print("Logged employee's type:  \(EmployeeType.getEmployeeTypeValue(employeeType)!.rawValue)")
            employeeStore.setObject(employeeLogged.employeeId, forKey: StringUtils.loginDefaults)
            employeeStore.synchronize()
        }
        else
        {
            print("Failed")
            // Do something to alert the user of incorrect password 'n' stuff.
        }
    }
}