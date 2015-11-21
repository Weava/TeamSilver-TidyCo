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
        let query: PFQuery = self.queryWithRelations()
        
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
        let query: PFQuery = self.queryWithRelations()
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
    
    func getServicesForEmployeeOnTodaysDate(employeeAssigned: Employee) -> [Service]?
    {
        let query: PFQuery = self.queryWithRelations()
        
        let startOfToday = NSCalendar.currentCalendar().startOfDayForDate(NSDate())
        
        query.whereKey("dateTimeAssigned", greaterThanOrEqualTo: startOfToday)
        
        do
        {
            return try query.findObjects() as? [Service]
        } catch
        {
            return nil
        }
    }
    
    func createService(service: Service)
    {
        service.saveInBackground()
    }
    
    func getAllServiceTypes() -> [ServiceType]?
    {
        let query: PFQuery = self.queryWithRelations()
        
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
        let query: PFQuery = ServiceType.query()!
        query.whereKey("typeName", equalTo: serviceType.rawValue)
        
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
    
    private func queryWithRelations() -> PFQuery!
    {
        let query: PFQuery = Service.query()!
        query.includeKey(Service.ROOM_SERVICED_RELATION)
        query.includeKey(Service.EMPLOYEE_ASSIGNED_RELATION)
        query.includeKey(Service.SERVICE_TYPE_RELATION)
        query.includeKey(Service.TIMER_RELATION)
        
        return query
    }
}