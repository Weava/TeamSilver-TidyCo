//
//  ParseEmployeeStorageAdapter.swift
//  TidyCo
//
//  Created by Aaron Weaver on 10/15/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import Foundation

class ParseEmployeeStorageAdapter : EmployeeStorageAdapter
{
    init()
    {
        
    }
    
    func getAllItems() -> [Employee]?
    {
        let query: PFQuery = Employee.query()!
        do
        {
            let allEmployees: [Employee] = try query.findObjects() as! [Employee]
            return allEmployees
        } catch
        {
            
        }
        return nil
    }
    
    func getEmployeeByFirstAndLast(firstName: String, lastName: String) -> Employee?
    {
        
        return nil
    }
    
    func createEmployee(employee: Employee)
    {
        employee.saveInBackground()
    }
    
    func checkLoginForEmployee(loginId: String, password: String) -> Employee?
    {
        var employeeArr: [Employee]
        let query: PFQuery = Employee.query()!
        
        query.whereKey("loginId", equalTo: loginId)
        query.whereKey("hashedPassword", equalTo: password)
        
        do
        {
            employeeArr = try query.findObjects() as! [Employee]
        } catch
        {
            return nil
        }
        
        if employeeArr.count == 0
        {
            return nil
        }
        else
        {
            return employeeArr.first
        }
    }
}