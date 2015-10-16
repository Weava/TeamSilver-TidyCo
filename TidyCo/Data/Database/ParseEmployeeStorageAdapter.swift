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
    init() { }
    
    func getAllItems() -> [Employee]?
    {
        let query: PFQuery = Employee.query()!
        do
        {
            let allEmployees: [Employee] = try query.findObjects() as! [Employee]
            return allEmployees
        } catch
        {
            return nil
        }
    }
    
    func getEmployeeByFirstAndLast(firstName: String, lastName: String) -> Employee?
    {
        
        return nil
    }
    
    func createEmployee(employee: Employee)
    {
        var employeesArr: [Employee]?
        
        let queryLogId: PFQuery = Employee.query()!
        queryLogId.whereKey("loginId", equalTo: employee.loginId)
        
        let queryEmpId: PFQuery = Employee.query()!
        queryEmpId.whereKey("employeeId", equalTo: employee.employeeId)
        
        let employeeExistsQuery: PFQuery = PFQuery.orQueryWithSubqueries([queryLogId, queryEmpId])
        
        do
        {
            employeesArr = try employeeExistsQuery.findObjects() as? [Employee]
            
            if employeesArr == nil || employeesArr?.count > 0
            {
                print("Employee already exists")
                return
            }
            else
            {
                employee.saveInBackground()
            }
        } catch
        {
            return
        }
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
    
    func getAllEmployeeTypes() -> [EmployeeType]?
    {
        let query: PFQuery = EmployeeType.query()!
        
        do
        {
            return try query.findObjects() as? [EmployeeType]
        } catch
        {
            return nil
        }
    }
    
    func getEmployeeTypeByName(employeeType: EmployeeTypeValue) -> EmployeeType?
    {
        var employeeTypeString: String
        
        switch employeeType
        {
            case EmployeeTypeValue.admin:
                employeeTypeString = "admin"
                break
            case EmployeeTypeValue.manager:
                employeeTypeString = "manager"
                break
            case EmployeeTypeValue.housekeeper:
                employeeTypeString = "housekeeper"
                break
            case EmployeeTypeValue.maintenance:
                employeeTypeString = "maintenance"
                break
        }
        
        let query: PFQuery = EmployeeType.query()!
        query.whereKey("typeName", equalTo: employeeTypeString)
        
        do
        {
            let typeArr: [EmployeeType] = try query.findObjects() as! [EmployeeType]
            if typeArr.count > 0
            {
                return typeArr.first
            }
            
        } catch
        {
            return nil
        }
        return nil
    }
}