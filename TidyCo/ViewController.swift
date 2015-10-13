//
//  ViewController.swift
//  TidyCo
//
//  Created by Aaron Weaver on 10/8/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // THIS IS ONLY A TEST
        // This should not be taken as an example on how to use Parse, only testing for my own purposes.
        let employeeTest: Employee = Employee()
        employeeTest.firstName = "Aaron"
        employeeTest.middleInitial = "L"
        employeeTest.lastName = "Weaver"
        let query = EmployeeType.query()
        query!.whereKey("typeName", equalTo: "admin")
        do
        {
            let employeeType: EmployeeType = try query?.findObjects().first as! EmployeeType
            let relation: PFRelation = employeeTest.relationForKey("employeeType")
            relation.addObject(employeeType)
            //employeeTest.employeeType = relation
        } catch {
            print("Couldn't find the employee type")
        }
        employeeTest.employeeId = "1234test"
        employeeTest.loginId = "testAdmin"
        employeeTest.hashedPassword = "realPass"
        employeeTest.saveInBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

