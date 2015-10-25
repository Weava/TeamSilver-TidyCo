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
        let query: PFQuery = Service.query()!
        do
        {
            let allServices: [Service] = try query.findObjects() as! [Service]
            return allServices
        } catch
        {
            return nil
        }
    }
    
    func getAllServicesForEmployee(employeeAssigned: Employee) -> [Service]?
    {
        let query: PFQuery = Service.query()!
        do
        {
            query.whereKey(Service.EMPLOYEE_ASSIGNED_RELATION, equalTo: employeeAssigned)
            let employeeServices: [Service] = try query.findObjects() as! [Service]
            return employeeServices
        } catch
        {
            return nil
        }
    }
    
    func createService(service: Service, serviceType: ServiceTypeValue, room: Room, employeeAssigned: Employee, timer: Timer)
    {
        service.relationForKey(Service.SERVICE_TYPE_RELATION)
            .addObject(self.getServiceTypeByName(serviceType)!);
        
        service.relationForKey(Service.ROOM_SERVICED_RELATION).addObject(room)
        service.relationForKey(Service.EMPLOYEE_ASSIGNED_RELATION).addObject(employeeAssigned)
        service.relationForKey(Service.TIMER_RELATION).addObject(timer)
        
        service.saveInBackground()
    }
    
    func getAllServiceTypes() -> [ServiceType]?
    {
        let query: PFQuery = ServiceType.query()!
        
        do
        {
            return try query.findObjects() as? [ServiceType]
        } catch
        {
            return nil
        }
    }
    
    func getServiceTypeByName(serviceType: ServiceTypeValue) -> ServiceType?
    {
        var serviceTypeString: String
        
        switch serviceType
        {
            case ServiceTypeValue.maintenance:
                serviceTypeString = "maintenance"
                break
            case ServiceTypeValue.housekeeping:
                serviceTypeString = "housekeeping"
                break
        }
        
        let query: PFQuery = ServiceType.query()!
        query.whereKey("typeName", equalTo: serviceTypeString)
        
        do
        {
            let typeArr: [ServiceType] = try query.findObjects() as! [ServiceType]
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