//
//  EmployeeStorageAdapter.swift
//  TidyCo
//
//  Created by Aaron Weaver on 10/15/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import Foundation

protocol EmployeeStorageAdapter
{
    func getAllItems() -> [Employee]?
    
    func getEmployeeByFirstAndLast(firstName: String, lastName: String) -> Employee?
    
    func createEmployee(employee: Employee)
    
    func checkLoginForEmployee(loginId: String, password: String) -> Employee?
    
    func getAllEmployeeTypes() -> [EmployeeType]?
    
    func getEmployeeTypeByName(employeeType: EmployeeTypeValue) -> EmployeeType?
}