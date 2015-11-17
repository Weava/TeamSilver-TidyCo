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
    let floorOps: ParseFloorStorageAdapter = ParseFloorStorageAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // THIS IS ONLY A TEST
        // This should not be taken as an example on how to use Parse, only testing for my own purposes.
        
        
        //employeeDbOperations.createEmployee(employeeTest, employeeType: EmployeeTypeValue.maintenance)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

