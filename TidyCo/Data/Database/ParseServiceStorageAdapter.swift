//
//  ParseServiceStorageAdapter.swift
//  TidyCo
//
//  Created by Aaron Weaver on 10/15/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import Foundation

class ParseServiceStorageAdapter : ServiceStorageAdapter
{
    func getAllServices() -> [Service]?
    {
        return nil
    }
    
    func getAllServicesForEmployee(employeeAssigned: Employee) -> [Service]?
    {
        return nil
    }
    
    func createService()
    {
        
    }
    
    func getAllServiceTypes() -> [ServiceType]?
    {
        return nil
    }
    
    func getServiceTypeByName(serviceType: ServiceTypeValue) -> ServiceType?
    {
        return nil
    }
}