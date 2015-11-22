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
    
    func getAllMaintenanceAndHousekeepingEmployees(storeNumber: String? = nil) -> [Employee]?
    {
        let query: PFQuery = Employee.query()!
        
        query.whereKey("employeeType", equalTo: getEmployeeTypeByName(EmployeeTypeValue.housekeeper)!)
        query.whereKey("employeeType", equalTo: getEmployeeTypeByName(EmployeeTypeValue.maintenance)!)
        
        // Find all employees unless storeNumber is given.
        if storeNumber != nil
        {
            query.whereKey("storeNumber", equalTo: storeNumber!)
        }
        
        do
        {
            return try query.findObjects() as? [Employee]
        } catch
        {
            print("Error finding employees")
            return nil
        }
    }
    
    func createEmployee(employee: Employee, employeeType: EmployeeTypeValue)
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
                //let relation: PFRelation = employee.relationForKey(Employee.EMPLOYEE_TYPE_RELATION)
                //relation.addObject(self.getEmployeeTypeByName(employeeType)!)
                employee[Employee.EMPLOYEE_TYPE_POINTER] = self.getEmployeeTypeByName(employeeType)
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
        query.includeKey(Employee.EMPLOYEE_TYPE_POINTER)
        
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
    
    func getEmployeeByEmployeeId(employeeId: String) -> Employee?
    {
        let employeeQuery: PFQuery = Employee.query()!
        
        employeeQuery.whereKey("employeeId", equalTo: employeeId)
        employeeQuery.includeKey("employeeType")
        
        do
        {
            if let employee: Employee = try employeeQuery.findObjects().first as? Employee
            {
                return employee
            }
        } catch
        {
            print("Could not retrieve employee by ID")
        }
        
        return nil
    }
    
//    func getEmployeeTypeFromEmployee(employee: Employee) -> EmployeeTypeValue?
//    {
//        let employeeType: PFRelation = employee.relationForKey(Employee.EMPLOYEE_TYPE_RELATION)
//        
//        do
//        {
//            let employeeTypeFromQuery: [EmployeeType] = try employeeType.query()?.findObjects() as! [EmployeeType]
//            
//            return EmployeeType.getEmployeeTypeValue(employeeTypeFromQuery.first!)
//        } catch
//        {
//            print("lol")
//        }
//        
//        return nil
//    }
    
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
        let employeeTypeString: String = employeeType.rawValue
        
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