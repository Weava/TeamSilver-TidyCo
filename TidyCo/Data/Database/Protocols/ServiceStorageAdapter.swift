//
//  ServiceStorageAdapter.swift
//  TidyCo
//
//  Created by Aaron Weaver on 10/15/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import Foundation

protocol ServiceStorageAdapter
{
    func getAllServices() -> [Service]?
    
    func getAllServicesForEmployee(employeeAssigned: Employee) -> [Service]?
    
    func createService(service: Service)
    
    func getAllServiceTypes() -> [ServiceType]?
    
    func getServiceTypeByName(serviceType: ServiceTypeValue) -> ServiceType?
}