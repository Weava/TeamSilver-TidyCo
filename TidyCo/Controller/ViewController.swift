//
//  ViewController.swift
//  TidyCo
//
//  Created by Aaron Weaver on 10/8/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let employeeDbOperations: ParseEmployeeStorageAdapter = ParseEmployeeStorageAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // THIS IS ONLY A TEST
        // This should not be taken as an example on how to use Parse, only testing for my own purposes.
        let employeeTest: Employee = Employee()
        employeeTest.firstName = "Main"
        employeeTest.middleInitial = "T"
        employeeTest.lastName = "Nancy"
        
        let relation: PFRelation = employeeTest.relationForKey("employeeType")
        relation.addObject(employeeDbOperations.getEmployeeTypeByName(EmployeeTypeValue.maintenance)!)
            
        employeeTest.employeeId = "maint420"
        employeeTest.loginId = "testMaint"
        employeeTest.hashedPassword = "realPass"
        employeeDbOperations.createEmployee(employeeTest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

